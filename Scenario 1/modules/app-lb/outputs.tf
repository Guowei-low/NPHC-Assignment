output "alb_id" {
  value       = "${join("", aws_lb.alb.*.id)}"
  description = "The ARN of the load balancer (matches arn)."
}
output "target_group_id" {
    value = aws_lb_target_group.default.*.id
    description = "The id of the Target Group"
}
output "listener_id" {
    value = aws_lb_listener.lb_listener.*.id
    description = "The ARN of the listener."
}
output "listener_arn" {
    value = aws_lb_listener.lb_listener.*.arn
    description = "The ARN of the listener."
}
output "target_group_arn" {
    value = aws_lb_target_group.default.*.arn
    description = "The ARNs of the Target Groups"
}