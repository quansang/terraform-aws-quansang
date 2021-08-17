#modules/route53-record-alias/variables.tf
#route53-record-alias
variable "zone_id" {}
variable "record_name" {}
variable "alias_dns_name" {}
variable "alias_zone_id" {}
variable "failover_routing_policy_type" { default = null }
variable "failover_routing_policy_set_identifier" { default = null }
variable "failover_routing_policy_health_check_id" { default = null }
