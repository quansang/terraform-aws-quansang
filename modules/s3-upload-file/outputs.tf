#modules/s3-upload-file/outputs.tf
output "s3_object_key" {
  value = aws_s3_bucket_object.upload_file.id
}
