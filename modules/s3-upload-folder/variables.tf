#modules/s3-upload-folder/variables.tf
#s3-upload-folder
variable "local_folder" {}
variable "s3_bucket_id" {}
variable "s3_folder" { default = null }
