variable "s3_bucketname" {  
  description = "name of the S3 bucket to store logs"  
}
variable "s3_bucketregion"{
  description = "region for the bucket" 
}
variable "lifecycle_rule_enabled" {
  default     = true
  type        = string
  description = "Specifies lifecycle rule status."
}
variable "lifecycle_rule_prefix" {
  default     = ""
  type        = string
  description = "Object key prefix identifying one or more objects to which the rule applies."
}
variable "standard_ia_transition_days" {
  default     = "30"
  type        = string
  description = "Specifies a period in the object's STANDARD_IA transitions."
}
variable "glacier_transition_days" {
  default     = "60"
  type        = string
  description = "Specifies a period in the object's Glacier transitions."
}
variable "expiration_days" {
  default     = "90"
  type        = string
  description = "Specifies a period in the object's expire."
}
variable "glacier_noncurrent_version_transition_days" {
  default     = "30"
  type        = string
  description = "Specifies when noncurrent object versions transitions."
}
variable "noncurrent_version_expiration_days" {
  default     = "60"
  type        = string
  description = "Specifies when noncurrent object versions expire."
}