# provision alb
resource "aws_lb" "alb" {
  name                       = var.alb_name
  security_groups            = var.enable_multiple_security_group_association ? var.alb_sgids_msg : [var.alb_sgids]
  subnets                    = var.alb_subnetids
  internal                   = var.alb_internal
  idle_timeout               = var.alb_idle_timeout
  enable_deletion_protection = var.enable_deletion_protection
  load_balancer_type         = "application"
  tags = {
    Name      = var.alb_name
    Terraform = true
  }
}

# provision target group
resource "aws_lb_target_group" "default" {
  count                = length(var.albtg_names)
  name                 = element(var.albtg_names, count.index)
  vpc_id               = var.vpc_id
  port                 = element(var.target_group_ports, count.index)
  protocol             = element(var.target_group_protocols, count.index)
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    path                = var.health_check_path
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
    port                = element(var.target_group_ports, count.index)
    protocol            = element(var.target_group_protocols, count.index)
  }

  stickiness {
    type            = var.stickiness_type
    cookie_duration = var.stickiness_cookie_duration
    enabled         = var.stickiness_enabled
  }

  tags = {
    Name      = element(var.albtg_names, count.index)
    Terraform = true
  }

  # force the creation of LB Target Group to be after the creation of Load Balancer.
  depends_on = [aws_lb.alb]
}

# create listner
resource "aws_lb_listener" "lb_listener" {
  count             = length(var.app_lb_listen_ports)
  load_balancer_arn = aws_lb.alb.arn
  port              = element(var.app_lb_listen_ports, count.index)
  protocol          = element(var.app_lb_listen_protocols, count.index)

  default_action {
    type             = "forward"
    target_group_arn = element(aws_lb_target_group.default.*.arn, count.index)
  }
  ssl_policy      = element(var.app_lb_listen_protocols, count.index) == "HTTPS" ? "ELBSecurityPolicy-2016-08" : null
  certificate_arn = element(var.app_lb_listen_protocols, count.index) == "HTTPS" ? var.certificate_arn : null
  # force the creation of LB Target Group to be after the creation of Load Balancer.
  depends_on = [aws_lb_target_group.default]
}

resource "aws_lb_listener_rule" "path_base_rule" {
  count        = var.app_lb_path_pattern_flag == "true" ? length(var.app_lb_fordward_path_condition_list) : 0
  listener_arn = element(aws_lb_listener.lb_listener.*.arn, length(aws_lb_listener.lb_listener.*.arn) > 1 ? count.index : 0)
  priority     = 100 + count.index * 10

  action {
    type             = "forward"
    target_group_arn = element(aws_lb_target_group.default.*.arn, count.index + 1)
  }

  condition {
    //field  ="path-pattern"    
    path_pattern {
      values = [element(var.app_lb_fordward_path_condition_list, count.index)]
    }
  }
}
