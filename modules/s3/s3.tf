#S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.name
  acl           = var.s3_bucket_acl
  force_destroy = true

  versioning {
    enabled    = var.s3_bucket_versioning
    mfa_delete = var.s3_bucket_mfa_delete
  }

  dynamic "logging" {
    for_each = var.s3_bucket_logging_target_bucket != null ? [1] : []
    content {
      target_bucket = var.s3_bucket_logging_target_bucket
      target_prefix = "s3-logs/${var.name}/${var.name}"
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.s3_bucket_lifecycle_rule_days != null ? [1] : []
    content {
      id      = "Lifecycle Rule"
      enabled = true

      transition {
        days          = var.s3_bucket_lifecycle_rule_days
        storage_class = "GLACIER"
      }
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.s3_bucket_server_side_encryption != null ? [1] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = var.s3_bucket_server_side_encryption
        }
        bucket_key_enabled = false #If enable will reduce AWS KMS request costs by up to 99 percent by decreasing the request traffic from Amazon S3 to AWS KMS but need more setting to PUT/COPY in sdk code or decrypt
      }
    }
  }

  tags = {
    Name  = var.name
    Stage = var.env
  }
}

#S3 Bucket policy
data "template_file" "s3_bucket_policy_template" {
  count    = var.s3_bucket_policy_template != null ? 1 : 0
  template = file("${var.s3_bucket_policy_template}.json")
  vars     = var.s3_bucket_policy_vars
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  count  = var.s3_bucket_policy_template != null ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.template_file.s3_bucket_policy_template[count.index].rendered
}
