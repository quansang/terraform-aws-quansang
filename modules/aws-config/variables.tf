#modules/aws-config/variables.tf
#basic
variable "env" {}
variable "project" {}

#aws-config
variable "configuration_recorder_role_arn" {}

variable "delivery_channel_s3_bucket_name" {}
variable "delivery_channel_sns_topic_arn" { default = null }
