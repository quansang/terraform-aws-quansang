#modules/ses/variables.tf
#basic
variable "env" {}
variable "project" {}
variable "region" {}

#ses
variable "ses_domain_identity" {}
variable "zone_id" {}

variable "smtp_user_name" { default = null }
variable "smtp_user_policy_template" { default = null }
variable "smtp_user_policy_vars" { default = null }

variable "enable_email_receiving" { default = false }

variable "ses_identity_notification_topic_arn" { default = null }
variable "ses_identity_notification_type" { default = ["Bounce", "Complaint"] }
