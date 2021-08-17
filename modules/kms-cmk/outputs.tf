#modules/kms-cmk/outputs.tf
output "kms_cmk_arn" {
  value = aws_kms_key.kms_cmk.arn
}
