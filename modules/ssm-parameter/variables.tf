#modules/ssm-parameter/variables.tf
#basic
variable "env" {}
variable "project" {}

#ssm-parameter
variable "ssm_parameter_name" {}
variable "ssm_parameter_value" {}
variable "kms_key_arn" {}
