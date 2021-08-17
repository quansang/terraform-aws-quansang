#modules/cloudwatch-alarm/variables.tf
#basic
variable "env" {}
variable "project" {}

#cloudwatch-alarm
variable "alarm_name_prefix" {} #Only set when project requires it
variable "alarm_name" {}
variable "metric_name" {}
variable "namespace" {}
variable "comparison_operator" {}
variable "statistic" {}
variable "threshold" {}
variable "unit" {}
variable "datapoints_to_alarm" {}
variable "evaluation_periods" {}
variable "period" {}
variable "alarm_description" {} #Only set when project requires it
variable "dimensions" {}
variable "alarm_actions" {}
variable "ok_actions" {}
