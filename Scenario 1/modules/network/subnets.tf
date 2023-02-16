# ------------------------------------------------------------------------------
# creates subnets \ route table \ route table association \ route, this section is for private subnet, No NAG, no ITG
# ------------------------------------------------------------------------------
resource "aws_subnet" "subnets" {  
  count                   = length(var.az_list)
  cidr_block              = element(var.subnets_cidr, count.index)
  vpc_id                  = var.vpc_id
  availability_zone       = element(var.az_list, count.index)
  tags = merge( {
    Name      = "${var.subnet_name}"
    Terraform = "true"
  })
}

resource "aws_route_table" "rtbl" {    
  vpc_id = var.vpc_id
  tags = merge( {
    Name      = "${var.subnet_name}"
    Terraform = "true"
  })
}

resource "aws_route_table_association" "rtbl-association" {
  count          = length(var.az_list)
  subnet_id      = element(aws_subnet.subnets.*.id, count.index) 
  route_table_id = aws_route_table.rtbl.id 
}

