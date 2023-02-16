variable "vpc_id" { 
  description = "id for vpc"
}
variable "sg_name" {  
  description = "security group name"  
}
variable "subnet_name" {  
  description = "subnet name"  
}
variable "sg_description" {
  default = "description for Security Group"
}