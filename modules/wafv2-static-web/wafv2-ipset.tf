resource "aws_wafv2_ip_set" "wafv2_ipset" {
  count              = var.wafv2_ipset_name != null ? 1 : 0
  name               = "${var.project}-${var.type}-wafv2-web-ipset-${var.env}"
  description        = "${var.project}-${var.type}-wafv2-web-ipset-${var.env} allow ${var.wafv2_ipset_name} IPs"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = var.wafv2_ipset_addresses

  tags = {
    Name        = "${var.project}-${var.type}-wafv2-web-ipset-${var.env}"
    Environment = var.env
    Project     = var.project
  }
}
