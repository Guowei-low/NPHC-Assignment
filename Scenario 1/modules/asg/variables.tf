variable "asg_name" {
  description = "Name tag"
}

/*
variable "asg_vpc_id" {
  description = "Vpc id"
}
*/

variable "asg_ami" {
  description = "AMI for the instance"
}

variable "asg_instance_profile" {
  description = "Instance profile for the service"
}

variable "asg_security_group_ids" {
  description = "Security group ids" 
}

variable "asg_subnet_ids" {
  description = "List of Subnets"
  type        = list
}

variable "asg_instance_type" {
  description = "Instance type"
  default     = "t2.nano"
}

variable "admin_ssh_key" {
  description = "Instance key name"
  default     = "default_instance_key"
}

variable "user_data" {
  description = "User Data"
}

variable "asg_max_size" {
  description = "ASG max size"
  default     = 1
}
variable "asg_min_size" {
  description = "ASG min size"
  default     = 1
}
variable "asg_desired_size" {
  description = "ASG desired size"
}
/*
variable "asg_load_balancers" {
  description = "Load Balancers to attach the ASG"
  type        = "list"
}
*/
variable "asg_associate_public_ip_address" {
  description = "Public IP mapping True/false"
  default     = "false"
}

variable "asg_subnet_name" {
  description = "Name of the subnet" 
}
/*
variable "sns_topicname" {
  description = "Name of the SNS Topic" 
}

variable "asg_keyname" {
  description = "Name of the SNS Topic" 
}
*/
variable "alb_targetgroup_arn" {
  description = "Name of the SNS Topic" 
} 
