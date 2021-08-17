resource "aws_route53_record" "route53_record_alias" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.alias_dns_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.failover_routing_policy_type == "PRIMARY" ? true : false
  }
  dynamic "failover_routing_policy" {
    for_each = var.failover_routing_policy_type != null ? [1] : []
    content {
      type = var.failover_routing_policy_type
    }
  }
  set_identifier  = var.failover_routing_policy_set_identifier
  health_check_id = var.failover_routing_policy_health_check_id
}
