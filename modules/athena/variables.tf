#modules/athena/variables.tf
#basic
variable "env" {}
variable "project" {}

#athena
variable "athena_database_name" {}
variable "athena_database_bucket" {}

variable "athena_workgroup_service" {}

variable "athena_named_query" {}

variable "encryption_option" { default = null }
variable "kms_key_arn" { default = null }
