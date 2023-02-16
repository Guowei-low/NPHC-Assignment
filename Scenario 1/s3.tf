# ------------------------------------------------------------------------------
# S3 Endpoint
# ------------------------------------------------------------------------------
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.ap-southeast-1.s3"
}
/*
data "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.ap-southeast-1.s3"
}
*/
resource "aws_vpc_endpoint_route_table_association" "s3" {
  route_table_id  = module.private_subnet.rtbl_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

module "nphc-assignment" {
  source          = "./modules/s3"
  s3_bucketname   = var.s3_bucketname
  s3_bucketregion = var.aws_region
}

resource "aws_s3_object" "nphc-assignment" {
  bucket = module.nphc-assignment.s3_bucket_id
  key    = "index.html"
  source = "./incremental-and-decremental-counter.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("incremental-and-decremental-counter.html")
}
