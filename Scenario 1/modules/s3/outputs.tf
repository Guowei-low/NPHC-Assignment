output "s3_bucket_id" {
  value       = "${aws_s3_bucket.S3.id}"
  description = "The name of the bucket."
}
output "s3_bucket_arn" {
  value       = "${aws_s3_bucket.S3.arn}"
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
}
output "s3_bucket_domain_name" {
  value       = "${aws_s3_bucket.S3.bucket_domain_name}"
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
}
output "s3_bucket_hosted_zone_id" {
  value       = "${aws_s3_bucket.S3.hosted_zone_id}"
  description = "The Route 53 Hosted Zone ID for this bucket's region."
}
output "s3_bucket_region" {
  value       = "${aws_s3_bucket.S3.region}"
  description = "The AWS region this bucket resides in."
}