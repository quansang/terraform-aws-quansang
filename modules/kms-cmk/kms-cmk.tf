# KMS CMKs
resource "aws_kms_key" "kms_cmk" {
  description = "${var.project}-${var.kms_key_name}-${var.env}"
  is_enabled  = true
}

# KMS CMKs Alias
resource "aws_kms_alias" "kms_cmk_alias" {
  name          = "alias/${var.project}-${var.region}-${var.kms_key_name}-${var.env}"
  target_key_id = aws_kms_key.kms_cmk.key_id
}
