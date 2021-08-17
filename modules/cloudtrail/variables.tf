#modules/cloudtrail/variables.tf
#basic
variable "env" {}
variable "project" {}

#cloudtrail
variable "name" {}
variable "s3_bucket_name" {}
variable "cloud_watch_logs_group_arn" { default = null }
variable "cloud_watch_logs_role_arn" { default = null }
variable "enable_log_file_validation" { default = false }
variable "is_multi_region_trail" { default = true }
variable "kms_key_id" { default = null }
variable "sns_topic_name" { default = null }
