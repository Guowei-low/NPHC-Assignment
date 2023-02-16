#----------------------------------------------------------------------------
# AWS VPC
#----------------------------------------------------------------------------
aws_region = "ap-southeast-1"
vpc_id = "vpc-3fbe5459"
// igw_id  = "igw-b7777dd3"
az_list = ["ap-southeast-1a", "ap-southeast-1b"]

#----------------------------------------------------------------------------
# Public Subnet, Security Group and ALB
#----------------------------------------------------------------------------

public_subnet_name = "server_fleet_alb"
public_cidr        = ["172.31.251.0/28", "172.31.251.16/28"]

alb_sg_rules = [
  {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    description = "allow inbound traffic from Internet"
  },
  {
    type        = "egress"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    description = "allow outbound traffic to ALB"
  }
]

# alb
alb_name    = "front-end-alb"
albtg_names = ["server-fleet-alb-tg"]


#----------------------------------------------------------------------------
# Private Subnet, Security Group and EC2
#----------------------------------------------------------------------------

private_subnet_name = "server_fleet_a"
private_cidr        = ["172.31.252.0/28", "172.31.252.16/28"]

sg_rules = [
  {
    type        = "egress"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    description = "allow outbound traffic to S3"
  },
  {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    description = "allow inbound traffic from ALB"
  },
  {
    type        = "egress"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    description = "allow outbound traffic within VPC"
  }
]

// ec2_count                       = 3
ec2_ami                         = "ami-0753e0e42b20e96e3"
ec2_name                        = "server_fleet_a"
ec2_instancetype                = "t2.micro"
ec2_associate_public_ip_address = false
ec2_rbd_volume_type             = "gp2"
ec2_rbd_volume_size             = 10
ec2_user_data                   = <<-EOF
  #!/bin/bash
  sudo yum update
  sudo amazon-linux-extras install -y nginx1
  sudo systemctl start nginx
  sudo systemctl enable nginx
  aws s3 sync s3://nphc-assignment/ /tmp/ --region ap-southeast-1
  sudo mv /tmp/index.html /usr/share/nginx/html/
EOF

#----------------------------------------------------------------------------
# Auto Scaling Group
#----------------------------------------------------------------------------
asg_name         = "server_fleet_a"
asg_max_size     = "3"
asg_min_size     = "2"
asg_desired_size = "3"
#----------------------------------------------------------------------------
# S3 bucket
#----------------------------------------------------------------------------
s3_bucketname = "nphc-assignment"
