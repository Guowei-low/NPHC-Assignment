# Variable for subnet
variable "subnet_name" {
  description = "name of the subnet"
}
# Variable for availibility zones
variable "az_list" {      
  description = "Define the number of AZ for each subnet block"
  type = list
}
# Variable for cidr range for subnets
variable "subnets_cidr" {
  description = "List of cidr ranges to be used in the subnets creation"
  type = list
}
# Variable for vpc id
variable "vpc_id" { 
  description = "id for vpc"
}
