###################
# Identity
###################
resource "aws_ses_domain_identity" "ses_domain_identity" {
  domain = var.ses_domain_identity
}

###################
# Verification Records
###################
#1. TXT Record
resource "aws_route53_record" "ses_verification_txt_record" {
  zone_id = var.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses_domain_identity.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain_identity.verification_token]
}

#2. DKIM Record
resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = aws_ses_domain_identity.ses_domain_identity.domain
}

resource "aws_route53_record" "ses_verification_dkim_record" {
  count = 3

  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.ses_domain_identity.id}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

###################
# Custom MAIL FROM
###################
#https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mail-from.html
#1. Domain Mail From
resource "aws_ses_domain_mail_from" "ses_domain_mail_from" {
  domain           = aws_ses_domain_identity.ses_domain_identity.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.ses_domain_identity.domain}"
}

#2. Domain Mail From - TXT Record
resource "aws_route53_record" "ses_domain_mail_from_verification_txt_record" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

#3. Domain Mail From - MX Record
resource "aws_route53_record" "ses_domain_mail_from_verification_mx_record" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${var.region}.amazonses.com"]
}
