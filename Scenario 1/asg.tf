# ------------------------------------------------------------------------------
# Auto Scaling Group
# ------------------------------------------------------------------------------

module "asg" {
  source                 = "./modules/asg"
  asg_name               = var.asg_name
  asg_max_size           = var.asg_max_size
  asg_min_size           = var.asg_min_size
  asg_desired_size       = var.asg_desired_size
  asg_ami                = var.ec2_ami
  asg_instance_type      = var.ec2_instancetype
  asg_security_group_ids = module.sg_ec2.sgid
  asg_instance_profile   = aws_iam_instance_profile.ec2-instance.name
  user_data              = var.ec2_user_data
  alb_targetgroup_arn    = [element(module.alb.target_group_arn, 0)]
  asg_subnet_ids         = module.private_subnet.subnets_id
  asg_subnet_name        = var.private_subnet_name
}
