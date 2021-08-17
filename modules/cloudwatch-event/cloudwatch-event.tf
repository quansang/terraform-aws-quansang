data "template_file" "cloudwatch_event_rule" {
  count    = var.cloudwatch_event_rule_template != null ? 1 : 0
  template = file("${var.cloudwatch_event_rule_template}.json")
  vars     = var.cloudwatch_event_rule_vars
}

resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = "${var.project}-${var.cloudwatch_event_rule_name}-event-${var.env}"
  description = var.cloudwatch_event_rule_description

  event_pattern       = var.cloudwatch_event_rule_template != null ? data.template_file.cloudwatch_event_rule[0].rendered : null
  schedule_expression = var.cloudwatch_event_rule_schedule_expression
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  target_id = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  arn       = var.cloudwatch_event_target_arn
  role_arn  = var.cloudwatch_event_target_role_arn
}
