variable "ec2_ami" {
  description = "ami id"
}
variable "ec2_count" {
  description = "count of EC2 instances"
}
variable "ec2_instancetype" {
  description = "type of instance"
}
variable "ec2_name" {
  description = "name of instance"
}
variable "ec2_subnetid" {
  description = "ec2 subnetid"
}
/*
variable "ec2_description" {
  description = "description of the ec2 instance"
}
variable "ec2_key_name" {
  description = "public key file name"
}
*/
variable "ec2_vpc_security_group_ids" {
  description = "Security group ids" 
}
variable "ec2_associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = false
}
variable "ec2_volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}
variable "ec2_root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}
variable "ec2_ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}
variable "ec2_ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  type        = list(map(string))
  default     = []
}
variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}
variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = "default"
}
/* Enable for ebs volume addition
variable "ebs_volume_availability_zone" {
  description = "availability zone of the ebs voume"
  type        = string
  default     = ""
}
variable "ebs_volume_size" {
  description = "size of the ebs voume"
  type        = string
  default     = ""
}
*/
variable "iam_instance_profile" {
  default = null
  type= string
  description ="iam instance profile"
}
variable "disable_api_termination" {
  default = false
  description =" (Optional) If true, enables EC2 Instance Termination Protection"
}
variable "ec2_user_data" {
  description = "user data of the ec2 instance"
}
/*
variable "hostname_tag" {
   type =string
   default =null
   description ="home name tag for EC2 instance"
}
variable "kms_key_id_root_ebs" {
   type =string
   default =null
   description ="KMS key Id to encrypt root EBS"
}
*/
variable "ec2_ebs_name" {
  description = "name of ebs"
  default     = ""
}
