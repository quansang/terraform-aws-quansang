data "archive_file" "zip" {
  type        = "zip"
  source_file = var.source_file_path #Only use if want to zip file
  source_dir  = var.source_dir_path  #Only use if want to zip folder/dir
  output_path = "${var.output_path}/${var.s3_bucket_key}.zip"
}

resource "aws_s3_bucket_object" "s3_upload_zip" {
  bucket       = var.s3_bucket_id
  key          = "${var.s3_bucket_key}.zip"
  source       = data.archive_file.zip.output_path
  content_type = "application/zip"

  etag = filemd5(data.archive_file.zip.output_path)
}
