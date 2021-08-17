#modules/s3-upload-zip/variables.tf
#s3-upload-zip
variable "source_file_path" { default = null }
variable "source_dir_path" { default = null }
variable "output_path" {}
variable "s3_bucket_key" {}

variable "s3_bucket_id" {}
