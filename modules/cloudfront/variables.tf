#modules/cloudfront/variables.tf
#basic
variable "env" {}
variable "project" {}

#cloudfront
variable "s3_bucket_domain_name" {}
variable "s3_bucket_id" {}
variable "default_root_object" { default = null }

variable "allowed_methods" { default = ["GET", "HEAD"] }
variable "cached_methods" { default = ["GET", "HEAD"] }
variable "default_ttl" { default = 3600 }
variable "max_ttl" { default = 86400 }
variable "lambda_arn" { default = null }

variable "s3_bucket_logs_domain_name" {}
variable "aliases_domain" { default = [] }

variable "cloudfront_default_certificate" { default = false }
variable "acm_certificate_arn" { default = null }
variable "ssl_support_method" { default = null }
variable "minimum_protocol_version" { default = null }

variable "custom_error_response" { default = [] }

variable "web_acl_id" { default = null }
variable "type" {}
