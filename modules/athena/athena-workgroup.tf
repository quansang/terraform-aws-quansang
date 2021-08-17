resource "aws_athena_workgroup" "athena_workgroup" {
  for_each = toset(var.athena_workgroup_service)

  name          = "${var.project}-${each.value}-workgroup-${var.env}"
  description   = "Export query result to ${each.value} folder in ${var.athena_database_bucket} bucket on ${var.env} env of ${var.project} project"
  state         = "ENABLED"
  force_destroy = false

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = false
    result_configuration {
      output_location = "s3://${var.athena_database_bucket}/${each.value}-query-result-${var.env}/"
      dynamic "encryption_configuration" {
        for_each = var.encryption_option != null ? [1] : []
        content {
          encryption_option = var.encryption_option
          kms_key_arn       = var.kms_key_arn
        }
      }
    }
  }

  tags = {
    Name        = "${var.project}-${each.value}-workgroup-${var.env}"
    Service     = each.value
    Environment = var.env
    Project     = var.project
  }
}
