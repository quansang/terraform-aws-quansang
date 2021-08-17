resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.project}: ${var.env}: ${var.s3_bucket_id}: Origin access identity"
}

resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = var.s3_bucket_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  enabled             = true
  wait_for_deployment = true
  is_ipv6_enabled     = false
  comment             = var.s3_bucket_id
  default_root_object = var.default_root_object

  #default behavior
  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.s3_bucket_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl

    # Associate lambda function to CF
    dynamic "lambda_function_association" {
      for_each = var.lambda_arn != null ? [1] : []
      content {
        event_type   = "viewer-request"
        lambda_arn   = var.lambda_arn
        include_body = false
      }
    }
  }

  logging_config {
    include_cookies = false
    bucket          = var.s3_bucket_logs_domain_name
    prefix          = "cf-logs/${var.s3_bucket_id}"
  }

  #domain
  aliases = var.aliases_domain

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.ssl_support_method
    minimum_protocol_version       = var.minimum_protocol_version
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response != [] ? var.custom_error_response : []
    content {
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
    }
  }

  #waf
  web_acl_id = var.web_acl_id

  tags = {
    Name  = "${var.project}-${var.type}-cloudfront-distribution-${var.env}"
    Type  = var.type
    Stage = var.env
  }
}
