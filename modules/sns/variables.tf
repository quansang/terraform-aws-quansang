#modules/sns/variables.tf
#basic
variable "env" {}
variable "project" {}
variable "account_id" {}

#sns
variable "sns_topic_name" {}
variable "service" {}
variable "inspector_region_id" { default = null }

variable "sns_topic_subscription_email_address" { default = [] }
