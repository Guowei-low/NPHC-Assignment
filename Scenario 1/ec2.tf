# ------------------------------------------------------------------------------
# Security Group
# ------------------------------------------------------------------------------
module "sg_ec2" {
  source      = "./modules/security-grp"
  vpc_id      = var.vpc_id
  sg_name     = var.private_subnet_name
  subnet_name = var.private_subnet_name
}

module "sg_rules" {
  source  = "./modules/secgrp-rules"
  sgrp_id = module.sg_ec2.sgid
  sg_rules = [
    merge(
      var.sg_rules[0],
      { cidr_blocks = null },
      { prefix_list_ids = [aws_vpc_endpoint.s3.prefix_list_id] },
      { security_groups = null }
    ),
    merge(
      var.sg_rules[1],
      { cidr_blocks = null },
      { prefix_list_ids = null },
      { security_groups = module.sg_alb.sgid }
    ),
    merge(
      var.sg_rules[2],
      { cidr_blocks = ["172.31.0.0/16"] },
      { prefix_list_ids = null },
      { security_groups = null }
    )
  ]
}

# ------------------------------------------------------------------------------
# Setup Private Subnet
# ------------------------------------------------------------------------------
module "private_subnet" {
  source       = "./modules/network"
  vpc_id       = var.vpc_id
  subnets_cidr = var.private_cidr
  az_list      = var.az_list
  subnet_name  = var.private_subnet_name
}

# ------------------------------------------------------------------------------
# EC2 Instance
# ------------------------------------------------------------------------------

/* module commented since ASG will create the instance using launch config
module "ec2" {
  source                          = "./modules/ec2"
  ec2_count                       = var.ec2_count
  ec2_name                        = var.ec2_name
  ec2_ami                         = var.ec2_ami
  ec2_instancetype                = var.ec2_instancetype
  ec2_associate_public_ip_address = var.ec2_associate_public_ip_address
  ec2_subnetid                    = module.private_subnet.subnets_id
  ec2_vpc_security_group_ids      = module.sg_ec2.sgid
  iam_instance_profile            = aws_iam_instance_profile.ec2-instance.name
  ec2_user_data = var.ec2_user_data
  ec2_root_block_device = [
    {
      delete_on_termination = true
      volume_type           = var.ec2_rbd_volume_type
      volume_size           = var.ec2_rbd_volume_size
    }
  ]
}
*/
# For EC2 Roles
resource "aws_iam_role" "ec2-instance" {
  name               = "iamr-server-fleet-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role       = aws_iam_role.ec2-instance.name
  count      = length(var.iam_policy_arn)
  policy_arn = var.iam_policy_arn[count.index]
}

variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type        = list(any)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

resource "aws_iam_instance_profile" "ec2-instance" {
  name = aws_iam_role.ec2-instance.name
  path = "/"
  role = aws_iam_role.ec2-instance.name
}
