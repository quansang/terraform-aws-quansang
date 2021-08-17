resource "aws_sns_topic_subscription" "sns_topic_subscription_email" {
  for_each = toset(var.sns_topic_subscription_email_address)

  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = each.value
}
