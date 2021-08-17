#modules/iam-role/variables.tf
#basic
variable "env" {}
variable "project" {}

#iam-role
variable "iam_assume_role_template" {}
variable "name" {}
variable "service" {}
variable "type" {}
variable "default_policy_arn" { default = null }
variable "iam_policy_template" { default = null }
variable "iam_policy_vars" { default = null }
variable "iam_instance_profile" { default = false }
