#modules/acm/outputs.tf
output "acm_cert_resource_record_name" {
  value = var.private_key == null ? tolist(aws_acm_certificate.acm_cert.domain_validation_options)[0].resource_record_name : null
}
output "acm_cert_resource_record_type" {
  value = var.private_key == null ? tolist(aws_acm_certificate.acm_cert.domain_validation_options)[0].resource_record_type : null
}
output "acm_cert_resource_record_value" {
  value = var.private_key == null ? tolist(aws_acm_certificate.acm_cert.domain_validation_options)[0].resource_record_value : null
}
output "acm_cert_arn" {
  value = aws_acm_certificate.acm_cert.arn
}
output "acm_cert_domain_name" {
  value = aws_acm_certificate.acm_cert.domain_name
}
