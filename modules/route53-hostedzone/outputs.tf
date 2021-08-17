#modules/route53-hostedzone/outputs.tf
output "hostedzone_name" {
  value = aws_route53_zone.hostedzone.name
}
output "hostedzone_zone_id" {
  value = aws_route53_zone.hostedzone.zone_id
}
