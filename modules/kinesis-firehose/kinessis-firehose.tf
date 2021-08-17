resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose" {
  name        = "${var.service}-${var.project}-${var.type}-kinesis-firehose-${var.env}" # MUST start with 'aws-waf-logs-' if using Kinesis Data Firehose delivery streams to WAF
  destination = "s3"

  s3_configuration {
    role_arn           = var.s3_configuration_iam_role_arn
    bucket_arn         = var.s3_configuration_bucket_arn
    prefix             = "${var.service}-from-${var.type}-kinesis-firehose/" #default = "kinesis-firehose-logs"
    buffer_interval    = 60
    buffer_size        = 5
    compression_format = "GZIP"

    cloudwatch_logging_options {
      enabled = false
    }
  }

  tags = {
    Name    = "${var.service}-${var.project}-${var.type}-kinesis-firehose-${var.env}"
    Stage   = var.env
    Service = var.service
    Type    = var.type
    Project = var.project
  }
}
