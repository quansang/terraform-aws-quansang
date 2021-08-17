resource "aws_wafv2_web_acl" "wafv2_app_acl" {
  name        = "${var.project}-${var.type}-wafv2-app-acl-${var.env}"
  description = "${var.project}: ${var.env}: ${var.type}-wafv2-app-acl"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # Define rule
  dynamic "rule" {
    for_each = var.wafv2_acl_rule
    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = "AWS"
          dynamic "excluded_rule" {
            for_each = try(rule.value.excluded_rule, [])
            content {
              name = excluded_rule.value
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

  tags = {
    Name        = "${var.project}-${var.type}-wafv2-app-acl-${var.env}"
    Environment = var.env
    Project     = var.project
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project}-${var.type}-wafv2-app-acl-metric-${var.env}"
    sampled_requests_enabled   = true
  }

  lifecycle { #Note: Add lifecycle for only this project
    ignore_changes = [rule]
  }
}

resource "aws_wafv2_web_acl_association" "wafv2_app_acl_association" {
  resource_arn = var.wafv2_acl_association_alb_arn
  web_acl_arn  = aws_wafv2_web_acl.wafv2_app_acl.arn
}

resource "aws_wafv2_web_acl_logging_configuration" "wafv2_app_acl_logging" {
  count                   = var.wafv2_acl_logging_destination_arn != [] ? 1 : 0
  log_destination_configs = var.wafv2_acl_logging_destination_arn
  resource_arn            = aws_wafv2_web_acl.wafv2_app_acl.arn
}
