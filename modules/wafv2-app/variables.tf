#modules/wafv2-app/variables.tf
#basic
variable "env" {}
variable "project" {}

#wafv2-app
variable "type" {}
variable "wafv2_acl_rule" {}

variable "wafv2_acl_association_alb_arn" {}

variable "wafv2_acl_logging_destination_arn" { default = [] }
