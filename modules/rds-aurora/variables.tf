#modules/rds-aurora/variables.tf
#basic
variable "env" {}
variable "project" {}

#rds-aurora
variable "aurora_database_engine" {}
variable "aurora_subnet_id" {}
variable "aurora_family" {}
variable "aurora_db_instance_parameters" {}
variable "aurora_cluster_parameters" {}
variable "aurora_cluster_engine_version" {}
variable "aurora_cluster_master_password" {}
variable "aurora_cluster_vpc_security_group_ids" {}
variable "aurora_cluster_kms_key_id" { default = null }
variable "aurora_instance_count" {}
variable "aurora_instance_class" {}
variable "aurora_instance_monitoring_role_arn" { default = null }
variable "aurora_instnace_monitoring_interval" { default = 0 }
variable "aurora_cluster_event_sns_topic_arn" { default = null }
