locals {
  lambda_handler = var.lambda_handler == null ? var.lambda_function_name : var.lambda_handler #Assign value for var.lambda_handler when Lambda code have different between environments
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "../../environment/lambda-function-code/${local.lambda_handler}.zip"
  function_name    = "${var.project}-${var.lambda_function_name}-lambda-${var.env}"
  description      = "from ${var.service}: to SNS trigger: to Lambda"
  role             = var.lambda_function_role_arn
  handler          = "${local.lambda_handler}.lambda_handler" #handler into function_name: the same file_name
  source_code_hash = filebase64sha256("../../environment/lambda-function-code/${local.lambda_handler}.zip")
  runtime          = "python3.7"

  timeout     = 60
  memory_size = 128

  dynamic "environment" {
    for_each = var.lambda_function_environment != [] ? [var.lambda_function_environment] : []
    content {
      variables = var.lambda_function_environment
    }
  }

  tracing_config {
    mode = "PassThrough"
  }

  tags = {
    Name    = "${var.project}-${var.lambda_function_name}-lambda-${var.env}"
    Stage   = var.env
    Service = var.service
    Project = var.project
  }
}

resource "aws_lambda_function_event_invoke_config" "lambda_function_event_invoke_config" {
  function_name                = aws_lambda_function.lambda_function.function_name
  qualifier                    = "$LATEST"
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 0
}

#==================================================================================
# For SNS
resource "aws_lambda_permission" "lambda_permission_sns" {
  for_each = var.service != "cloudwatch-logs" ? var.lambda_permission_sns_arn : {}

  statement_id  = "AllowExecutionFromSNS-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = each.value
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  for_each = var.service != "cloudwatch-logs" ? var.lambda_permission_sns_arn : {}

  topic_arn = each.value
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_function.arn
}

#==================================================================================
# For Cloudwatch Logs
data "aws_cloudwatch_log_group" "log_group" {
  for_each = var.service == "cloudwatch-logs" ? { for value in var.cloudwatch_logs : value.log_subscription_filter_name => value } : {}
  name     = each.value.log_group_name
}

resource "aws_lambda_permission" "lambda_permission_cloudwatch_logs" {
  for_each = var.service == "cloudwatch-logs" ? { for value in var.cloudwatch_logs : value.log_subscription_filter_name => value } : {}

  statement_id  = "${each.value.log_subscription_filter_name}-AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.arn
  principal     = "logs.${var.region}.amazonaws.com"
  source_arn    = data.aws_cloudwatch_log_group.log_group[each.key].arn
}

resource "aws_cloudwatch_log_subscription_filter" "log_subscription_filter" {
  for_each = var.service == "cloudwatch-logs" ? { for value in var.cloudwatch_logs : value.log_subscription_filter_name => value } : {}

  name            = "${var.project}-${each.value.log_subscription_filter_name}-filter-${var.env}"
  log_group_name  = each.value.log_group_name
  filter_pattern  = each.value.log_subscription_filter_pattern
  destination_arn = aws_lambda_function.lambda_function.arn
}
