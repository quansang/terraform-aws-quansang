#modules/s3/variables.tf
#basic
variable "env" {}

#s3
variable "name" {}
variable "s3_bucket_acl" { default = "private" }
variable "s3_bucket_versioning" { default = false }
variable "s3_bucket_mfa_delete" { default = false }
variable "s3_bucket_logging_target_bucket" { default = null }
variable "s3_bucket_lifecycle_rule_days" { default = null }
variable "s3_bucket_server_side_encryption" { default = null }
variable "s3_bucket_policy_template" { default = null }
variable "s3_bucket_policy_vars" { default = null }
