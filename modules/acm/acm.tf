#Create ACM
resource "aws_acm_certificate" "acm_cert" {
  domain_name               = var.domain
  subject_alternative_names = var.private_key == null ? ["*.${var.domain}"] : null #If don't import SSL Certificate, will create Wilcard SSL alternative
  validation_method         = var.private_key == null ? var.validation_method : null

  #Custom SSL
  private_key       = var.private_key
  certificate_body  = var.certificate_body
  certificate_chain = var.certificate_chain

  tags = {
    Name        = var.domain
    Environment = var.env
    Stage       = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}
