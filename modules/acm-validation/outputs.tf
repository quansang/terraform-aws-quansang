#modules/acm-validation/outputs.tf
output "acm_validation_certificate_arn" {
  value = aws_acm_certificate_validation.acm_validation.certificate_arn
}
