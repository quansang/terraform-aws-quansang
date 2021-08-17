#modules/budgets/variables.tf
#basic
variable "env" {}
variable "project" {}

#budget
variable "limit_amount" {}
variable "time_period_start" {}
variable "threshold" {}
variable "subscriber_email_addresses" {}
variable "subscriber_sns_topic_arns" {}
