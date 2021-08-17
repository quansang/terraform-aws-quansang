#modules/cloudwatch-event/variables.tf
#basic
variable "env" {}
variable "project" {}

#cloudwatch-event
variable "cloudwatch_event_rule_template" { default = null }
variable "cloudwatch_event_rule_vars" { default = null }
variable "cloudwatch_event_rule_schedule_expression" { default = null }

variable "cloudwatch_event_rule_name" {}
variable "cloudwatch_event_rule_description" {}

variable "cloudwatch_event_target_arn" {}
variable "cloudwatch_event_target_role_arn" { default = null }
