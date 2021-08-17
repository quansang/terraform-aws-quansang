#modules/lambda/variables.tf
#basic
variable "env" {}
variable "project" {}
variable "region" {}

#lambda
variable "lambda_function_name" {}
variable "lambda_handler" { default = null }
variable "service" {}
variable "lambda_function_role_arn" {}
variable "lambda_function_environment" { default = [] }

variable "lambda_permission_sns_arn" { default = null }

variable "cloudwatch_logs" { default = {} }
