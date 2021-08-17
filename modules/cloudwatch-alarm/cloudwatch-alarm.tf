resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
  count = length(var.alarm_name)

  # alarm_name          = "${var.project}-${element(var.alarm_name, count.index)}-${var.env}"
  alarm_name          = "${element(var.alarm_name_prefix, count.index)}${var.project}-${element(var.alarm_name, count.index)}-${var.env}"
  metric_name         = element(var.metric_name, count.index)
  namespace           = element(var.namespace, count.index)
  comparison_operator = element(var.comparison_operator, count.index)
  statistic           = element(var.statistic, count.index)
  threshold           = element(var.threshold, count.index)
  datapoints_to_alarm = element(var.datapoints_to_alarm, count.index)
  evaluation_periods  = element(var.evaluation_periods, count.index) # Evaluation Period must to larger than Datapoints
  period              = element(var.period, count.index)
  treat_missing_data  = "notBreaching"
  # alarm_description   = "${element(var.statistic, count.index)} of ${element(var.alarm_name, count.index)} ${element(var.comparison_operator, count.index)} is ${element(var.threshold, count.index)}${element(var.unit, count.index)}: Reach ${element(var.datapoints_to_alarm, count.index)} times in ${element(var.evaluation_periods, count.index)}x${element(var.period, count.index)} seconds"
  alarm_description = var.env == "prod" ? element(var.alarm_description, count.index) : "${element(var.statistic, count.index)} of ${element(var.alarm_name, count.index)} ${element(var.comparison_operator, count.index)} is ${element(var.threshold, count.index)}${element(var.unit, count.index)}: Reach ${element(var.datapoints_to_alarm, count.index)} times in ${element(var.evaluation_periods, count.index)}x${element(var.period, count.index)} seconds"

  dimensions = element(var.dimensions, count.index)

  alarm_actions = element(var.alarm_actions, count.index)
  ok_actions    = element(var.ok_actions, count.index)
}
