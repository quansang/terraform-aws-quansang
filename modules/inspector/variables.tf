#modules/inspector/variables.tf
#basic
variable "project" {}
variable "env" {}
variable "region" {}
variable "profile" {}

#inspector
variable "inspector_resource_group_tags" {}
variable "inspector_assessment_target_name" {}
variable "inspector_assessment_template_name" {}
variable "inspector_assessment_template_rules_package_arns" {}
variable "inspector_assessment_template_sns_topic_arn" {}
