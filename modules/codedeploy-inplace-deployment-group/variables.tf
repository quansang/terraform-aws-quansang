#modules/codedeploy-inplace-deployment-group/variables.tf
#basic
variable "env" {}
variable "project" {}

#codedeploy-inplace-deployment-group
variable "codedeploy_app_name" {}
variable "type" {}
variable "service_role_arn" {}
variable "autoscaling_groups_name" {}
variable "trigger_sns_topic_name" { default = null }
variable "trigger_target_sns_topic_arn" { default = null }
