resource "aws_cloudtrail" "cloudtrail" {
  name = "${var.project}-trail-${var.name}-${var.env}"

  # Setting this to false will pause logging.
  enable_logging = true

  # Send logs to S3
  s3_bucket_name = var.s3_bucket_name

  # Send logs to CloudWatch Logs
  cloud_watch_logs_group_arn = var.cloud_watch_logs_group_arn != null ? "${var.cloud_watch_logs_group_arn}:*" : null
  cloud_watch_logs_role_arn  = var.cloud_watch_logs_role_arn

  enable_log_file_validation    = var.enable_log_file_validation
  include_global_service_events = true
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = false

  kms_key_id     = var.kms_key_id
  sns_topic_name = var.sns_topic_name

  tags = {
    Name        = "${var.project}-trail-${var.name}-${var.env}"
    Stage       = var.env
    Environment = var.env
  }
}
