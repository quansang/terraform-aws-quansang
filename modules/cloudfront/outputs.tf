#modules/cloudfront/outputs.tf
output "origin_access_identity_iam_arn" {
  value = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cloudfront.domain_name
}
output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.cloudfront.hosted_zone_id
}
