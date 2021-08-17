#modules/redis/variables.tf
#basic
variable "env" {}
variable "project" {}

#redis
variable "redis_subnet_id" {}
variable "redis_automatic_failover_enabled" {}
variable "redis_multi_az_enabled" {}
variable "redis_node_type" {}
variable "redis_number_cache_clusters" {}
variable "redis_parameter_group_name" {}
variable "redis_engine_version" {}
variable "redis_security_group_ids" {}
variable "redis_sns_topic_arn" { default = null }
