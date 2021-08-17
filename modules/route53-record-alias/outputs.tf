#modules/route53-record-alias/outputs.tf
output "route53_record_alias_name" {
  value = aws_route53_record.route53_record_alias.name
}
