resource "aws_budgets_budget" "budgets" {
  name              = "${var.project}-budgets-${var.env}"
  budget_type       = "COST"
  limit_unit        = "USD"
  limit_amount      = var.limit_amount
  time_period_start = var.time_period_start
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.subscriber_email_addresses
    subscriber_sns_topic_arns  = var.subscriber_sns_topic_arns
  }
}
