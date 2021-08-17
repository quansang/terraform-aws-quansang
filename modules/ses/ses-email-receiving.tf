# Email Receiving - MX Record
resource "aws_route53_record" "ses_verification_mx_record_receiving" {
  count = var.enable_email_receiving == true ? 1 : 0

  zone_id = var.zone_id
  name    = aws_ses_domain_identity.ses_domain_identity.id
  type    = "MX"
  ttl     = "600"
  records = ["10 inbound-smtp.us-east-1.amazonaws.com"]
}
