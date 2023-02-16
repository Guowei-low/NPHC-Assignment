# ------------------------------------------------------------------------------
# Setup Public Subnet
# ------------------------------------------------------------------------------
module "public_subnet" {
  source       = "./modules/network"
  vpc_id       = var.vpc_id
  subnets_cidr = var.public_cidr
  az_list      = var.az_list
  subnet_name  = var.public_subnet_name
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_route" "Internet" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = module.public_subnet.rtbl_ids[0]
  gateway_id             = data.aws_internet_gateway.igw.internet_gateway_id
}

# ------------------------------------------------------------------------------
# ALB
# ------------------------------------------------------------------------------
module "sg_alb" {
  source      = "./modules/security-grp"
  vpc_id      = var.vpc_id
  sg_name     = var.public_subnet_name
  subnet_name = var.public_subnet_name
  #  sg_rules = var.alb_sg_rules
}

module "alb_sg_rules" {
  source  = "./modules/secgrp-rules"
  sgrp_id = module.sg_alb.sgid
  sg_rules = [
    merge(
      var.alb_sg_rules[0],
      { cidr_blocks = ["0.0.0.0/0"] },
      { prefix_list_ids = null },
      { security_groups = null }
    ),
    merge(
      var.alb_sg_rules[1],
      { cidr_blocks = null },
      { prefix_list_ids = null },
      { security_groups = module.sg_ec2.sgid }
    )
  ]
}

module "alb" {
  source                     = "./modules/app-lb"
  vpc_id                     = var.vpc_id
  alb_name                   = var.alb_name
  alb_subnetids              = module.public_subnet.subnets_id
  alb_internal               = "false"
  alb_sgids                  = module.sg_alb.sgid
  albtg_names                = var.albtg_names
  app_lb_listen_ports        = ["80"]
  app_lb_listen_protocols    = ["HTTP"]
  target_group_ports         = ["80"]
  target_group_protocols     = ["HTTP"]
  enable_deletion_protection = false
}
/*
resource "aws_lb_target_group_attachment" "alb_group_attachment_80" {
  count            = var.ec2_count
  target_group_arn = element(module.alb.target_group_arn, 0)
  target_id        = element(module.ec2.ec2_id, count.index)
  port             = 80
}
*/