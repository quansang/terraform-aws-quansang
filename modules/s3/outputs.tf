#modules/s3/outputs.tf
output "s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}
output "s3_bucket_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}
output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket" {
  value = aws_s3_bucket.s3_bucket.bucket
}
