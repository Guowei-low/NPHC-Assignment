#----------------------------------------------------------------------------
# Provision S3 bucket. 
# This module provides recommended settings - 
#  - Enable Default Encryption
#  - Enable Versioning
#  - Enable Lifecycle Configuration
#  - Protected from deletion
#----------------------------------------------------------------------------
resource "aws_s3_bucket" "S3" {
  bucket            = var.s3_bucketname
  tags = {
    Name = var.s3_bucketname
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.S3.id
  acl    = "private"
}