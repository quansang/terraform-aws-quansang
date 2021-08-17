#modules/s3-upload-folder/outputs.tf
output "s3_object_keys" {
  value = { for key, value in aws_s3_bucket_object.upload_folder : key => value.id }
}
