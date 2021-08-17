#Create AWS WAF_v2 ACL for Static Web
resource "aws_wafv2_web_acl" "wafv2_static_web_acl" {
  name        = "${var.project}-${var.type}-wafv2-static-web-acl-${var.env}"
  description = "${var.project}: ${var.env}: ${var.type}-wafv2-static-web-acl"
  scope       = "CLOUDFRONT"

  default_action {
    dynamic "block" {
      for_each = var.wafv2_acl_default_action == "block" ? [1] : []
      content {}
    }
    dynamic "allow" {
      for_each = var.wafv2_acl_default_action == "allow" ? [1] : []
      content {}
    }
  }

  # Define rule ipset
  dynamic "rule" {
    for_each = var.wafv2_ipset_name != null ? [1] : []
    content {
      name     = "${var.project}-${var.type}-wafv2-web-ipset-${var.env}"
      priority = 1
      action {
        allow {}
      }
      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.wafv2_ipset[0].arn
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "${var.project}-${var.type}-wafv2-web-ipset-${var.env}"
        sampled_requests_enabled   = false
      }
    }
  }

  # Define rule byte match
  dynamic "rule" {
    for_each = var.wafv2_acl_bytematch_rule != null ? var.wafv2_acl_bytematch_rule : []
    content {
      name     = "${var.project}-${var.type}-${rule.value["name"]}-bytematch-rule-${var.env}"
      priority = rule.value["priority"]
      action {
        allow {}
      }
      statement {
        byte_match_statement {
          positional_constraint = "CONTAINS"
          search_string         = rule.value["search_string"]

          field_to_match {
            single_header {
              name = rule.value["single_header_name"]
            }
          }

          text_transformation {
            priority = 0
            type     = "NONE"
          }
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "${var.project}-${var.type}-${rule.value["name"]}-bytematch-rule-metric-${var.env}"
        sampled_requests_enabled   = false
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project}-${var.type}-wafv2-static-web-acl-metric-${var.env}"
    sampled_requests_enabled   = true
  }

  tags = {
    Name        = "${var.project}-${var.type}-wafv2-static-web-acl-${var.env}"
    Environment = var.env
    Project     = var.project
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "wafv2_app_acl_logging" {
  count                   = var.wafv2_acl_logging_destination_arn != [] ? 1 : 0
  log_destination_configs = var.wafv2_acl_logging_destination_arn
  resource_arn            = aws_wafv2_web_acl.wafv2_static_web_acl.arn
}
