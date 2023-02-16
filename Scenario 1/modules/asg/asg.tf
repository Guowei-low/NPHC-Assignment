resource "aws_launch_configuration" "alc" {
  name                        = "${var.asg_name}-lc"  
  image_id                    = var.asg_ami
  instance_type               = var.asg_instance_type
  security_groups             = [var.asg_security_group_ids]
  associate_public_ip_address = var.asg_associate_public_ip_address
  user_data                   = var.user_data
  iam_instance_profile        = var.asg_instance_profile

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  launch_configuration      = aws_launch_configuration.alc.name
  vpc_zone_identifier       = var.asg_subnet_ids
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_size
  target_group_arns         = var.alb_targetgroup_arn
  health_check_grace_period = "120"
  health_check_type         = "ELB"
  min_elb_capacity          = "1"

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = var.asg_name
      propagate_at_launch = true
    },
    {
      key                 = "Tier"
      value               = var.asg_subnet_name
      propagate_at_launch = true
    },
  ]
}
