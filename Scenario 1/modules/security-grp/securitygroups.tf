# ------------------------------------------------------------------------------
# creates security group 
# ------------------------------------------------------------------------------
resource "aws_security_group" "sgrp" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
  tags = {
   Name      = var.sg_name   
   Terraform = "true"
  }
}
