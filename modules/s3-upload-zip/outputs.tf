#modules/s3-upload-zip/outputs.tf
output "s3_upload_zip_id" {
  value = aws_s3_bucket_object.s3_upload_zip.id
}
