#Create HostedZone
resource "aws_route53_zone" "hostedzone" {
  name          = var.domain
  comment       = "DNS for ${var.domain} on ${var.env} Environment of ${var.project} project"
  force_destroy = false

  tags = {
    Stage = var.env
  }
}
