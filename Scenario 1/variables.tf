# AWS Account Information
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}
/*
variable "igw_id" {
  description = "Internet Gateway id"
  type        = string
}
*/
variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}
variable "az_list" {
  description = "Define the number of AZ for each subnet block"
  type        = list(any)
}

# ALB Variables
variable "public_subnet_name" {
  description = "Subnet Name"
  type        = string
}
variable "public_cidr" {
  description = "Public Subnet CIDR"
  type        = list(any)
}
variable "alb_sg_rules" {
  description = "security group rules"
  type        = list(any)
}
variable "alb_name" {
  description = "name of the application load balancer"
}
variable "albtg_names" {
  type        = list(any)
  description = "a list name of the alb target groups."
}
/*
variable "alb_subnetids" {
  description = "subnet ids"
}
variable "alb_internal" {
  description = "internal or external alb"
}
variable "alb_sgids" {
  description = "security group ids"
}
variable "app_lb_listen_ports" {
  description = "ALB Listeing Ports"
  type        = list(any)
}
variable "app_lb_listen_protocols" {
  description = "ALB Listeing Ports"
  type        = list(any)
}
variable "target_group_ports" {
  description = "Target group rules"
  type        = list(any)
}
variable "target_group_protocols" {
  description = "Target group protocols"
  type        = list(any)
}
variable "enable_deletion_protection" {
  default     = false
  description = " (Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer, default is false"
}
*/
# EC2 Variables
variable "private_subnet_name" {
  description = "Subnet Name"
  type        = string
}
variable "private_cidr" {
  description = "Private Subnet CIDR"
  type        = list(any)
}
variable "sg_rules" {
  description = "Security Group rules"
  type        = list(any)
}
variable "ec2_ami" {
  description = "ami id"
}
/*
variable "ec2_count" {
  description = "count of EC2 instances"
}
*/
variable "ec2_instancetype" {
  description = "type of instance"
}
variable "ec2_name" {
  description = "name of instance"
}
variable "ec2_associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
}
variable "ec2_rbd_volume_type" {
  description = "ec2 rbd volume type"
}
variable "ec2_rbd_volume_size" {
  description = "ec2 rbd volume size"
}
variable "ec2_user_data" {
  description = "User Data"
}

# ASG Variables
variable "asg_name" {
  description = "Name tag"
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
# S3 Variables
variable "s3_bucketname" {
  description = "name of the S3 bucket to store logs"
}
/*
variable "s3_bucketregion" {
  description = "region for the bucket"
}
*/
