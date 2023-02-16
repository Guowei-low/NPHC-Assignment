
resource "aws_instance" "ec2" {
  count                       = var.ec2_count
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instancetype
  subnet_id                   = element(var.ec2_subnetid, count.index)
  vpc_security_group_ids      = [var.ec2_vpc_security_group_ids]
  associate_public_ip_address = var.ec2_associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  disable_api_termination     = var.disable_api_termination
  user_data                   = var.ec2_user_data

  dynamic "root_block_device" {
    for_each = var.ec2_root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  // additional customer tags
  tags = merge({
    Name      = "${var.ec2_name}"
    Terraform = "true"
  })
}
