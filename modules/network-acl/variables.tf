#modules/network-acl/variables.tf
#basic
variable "env" {}
variable "project" {}

#network-acl
variable "acl_vpc_id" {}
variable "acl_subnet_ids" {}
variable "acl_name" {}
variable "acl_rule" { default = {} }
