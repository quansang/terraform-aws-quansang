#modules/alb/variables.tf
#basic
variable "env" {}
variable "project" {}

#alb
variable "type" {}
variable "alb_security_groups_id" {}
variable "alb_subnets_id" {}
variable "alb_bucket_id" {}

variable "alb_target_group_vpc_id" {}
variable "alb_target_group_target_type" {}
variable "alb_target_group_healthcheck_path" {}

#alb-listener
variable "alb_listener" {}

#alb-listener-rule
variable "alb_listener_rule" { default = {} }
