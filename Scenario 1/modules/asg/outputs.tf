
output "asg_arn" {
  value = "${aws_autoscaling_group.asg.arn}"
}
output "asg_name" {
  description = "The autoscaling group name"
  value       = "${aws_autoscaling_group.asg.name}"
  
}