#DNS cert validation for ACM
resource "aws_route53_record" "cert_validation_record" {
  zone_id = var.hostedzone_zone_id
  name    = var.acm_cert_resource_record_name
  type    = var.acm_cert_resource_record_type
  records = [var.acm_cert_resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn         = var.acm_cert_arn
  validation_record_fqdns = [aws_route53_record.cert_validation_record.fqdn]
}
