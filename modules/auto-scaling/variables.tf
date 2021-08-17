#modules/auto-scaling/variables.tf
#basic
variable "env" {}
variable "project" {}
variable "region" {}

#auto-scaling
variable "type" {}

variable "launch_config_ami_id" {}
variable "launch_config_instance_type" {}
variable "launch_config_security_groups_id" {}
variable "launch_config_iam_instance_profile" {}
variable "launch_config_volume_size" {}
variable "launch_config_user_data" { default = null }
variable "launch_config_enable_monitoring" { default = false } #Default: Using Basic Monitoring

variable "autoscaling_group_subnet_ids" {}
variable "autoscaling_group_alb_target_group_arns" { default = null }
variable "autoscaling_group_health_check_type" {}
variable "autoscaling_group_desired_capacity" {}
variable "autoscaling_group_min_size" {}
variable "autoscaling_group_max_size" {}
variable "autoscaling_group_termination_policies" {}
variable "autoscaling_group_suspended_processes" { default = null }

variable "autoscaling_notification_topic_arn" { default = null }

variable "autoscaling_policy" { default = {} }
