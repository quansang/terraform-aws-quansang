resource "aws_athena_database" "athena_database" {
  name   = "${var.project}_${var.athena_database_name}_database_${var.env}" #must be lowercase. Special characters other than underscore (_) are not supported
  bucket = var.athena_database_bucket

  dynamic "encryption_configuration" {
    for_each = var.encryption_option != null ? [1] : []
    content {
      encryption_option = var.encryption_option
      kms_key           = var.kms_key_arn
    }
  }
  force_destroy = false
}
