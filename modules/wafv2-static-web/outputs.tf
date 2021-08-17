#modules/wafv2-static-web/outputs.tf
#wafv2-ipset
output "wafv2_ipset_arn" {
  value = aws_wafv2_ip_set.wafv2_ipset[0].arn
}

#wafv2-acl
output "wafv2_static_web_acl_arn" {
  value = aws_wafv2_web_acl.wafv2_static_web_acl.arn
}
output "wafv2_static_web_acl_name" {
  value = aws_wafv2_web_acl.wafv2_static_web_acl.name
}
output "wafv2_static_web_acl_metric_name" {
  value = aws_wafv2_web_acl.wafv2_static_web_acl.visibility_config[0].metric_name
}
