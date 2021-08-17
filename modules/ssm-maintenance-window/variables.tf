#modules/ssm-maintenance-window/variables.tf
#basic
variable "env" {}
variable "project" {}

#ssm-maintenance-window
variable "scan_window_target_ServerType" {}

variable "scan_window_task_role_arn" {}
variable "scan_window_task_notification_arn" { default = null }
