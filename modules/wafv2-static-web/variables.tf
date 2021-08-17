#modules/wafv2-static-web/variables.tf
#basic
variable "env" {}
variable "project" {}
variable "type" {}

#wafv2-ipset
variable "wafv2_ipset_name" { default = null }
variable "wafv2_ipset_addresses" { default = null }

#wafv2-acl
variable "wafv2_acl_default_action" { default = "block" }
variable "wafv2_acl_bytematch_rule" { default = null }

variable "wafv2_acl_logging_destination_arn" { default = [] }
