#modules/security-group/variables.tf
#basic
variable "env" {}
variable "project" {}

#security-group
variable "name" {}
variable "vpc_id" {}
variable "type" {}
variable "security_group_rule_egress" { default = {} }
variable "security_group_rule_ingress" { default = {} }
