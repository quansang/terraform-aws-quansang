#modules/acm/variables.tf
#basic
variable "env" {}

#acm
variable "domain" { default = null }
variable "validation_method" { default = "DNS" }
variable "private_key" { default = null }
variable "certificate_body" { default = null }
variable "certificate_chain" { default = null }
