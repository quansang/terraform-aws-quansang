###################
# Logs
###################
module "s3_bucket_logs" {
  source  = "quansang/quansang/aws//modules/s3"
  version = "0.0.1"
  #basic
  env = var.env

  #s3
  name                             = "${var.project}-logs-${var.env}"
  s3_bucket_acl                    = "log-delivery-write"
  s3_bucket_versioning             = true
  s3_bucket_lifecycle_rule_days    = 730
  s3_bucket_server_side_encryption = "AES256"
  s3_bucket_policy_template        = "${path.module}/s3-policy-template/s3-logs"
  s3_bucket_policy_vars = {
    s3_bucket_id  = module.s3_bucket_logs.s3_bucket_id
    account_id    = var.account_id
    elb_region_id = var.elb_region_id
    s3_bucket_arn = module.s3_bucket_logs.s3_bucket_arn
  }
}

###################
# Secrets
###################
module "s3_bucket_secrets" {
  source  = "quansang/quansang/aws//modules/s3"
  version = "0.0.1"
  #basic
  env = var.env

  #s3
  name                             = "${var.project}-secrets-${var.env}"
  s3_bucket_versioning             = true
  s3_bucket_logging_target_bucket  = module.s3_bucket_logs.s3_bucket_id
  s3_bucket_server_side_encryption = "AES256"
  s3_bucket_policy_template        = "${path.module}/s3-policy-template/s3-http-deny"
  s3_bucket_policy_vars = {
    s3_bucket_arn = module.s3_bucket_secrets.s3_bucket_arn
  }
}

###################
# Codedeploy
###################
module "s3_bucket_ec2_codedeploy_app" {
  source  = "quansang/quansang/aws//modules/s3"
  version = "0.0.1"
  #basic
  env = var.env

  #s3
  name                             = "${var.project}-ec2-codedeploy-app-${var.env}"
  s3_bucket_versioning             = true
  s3_bucket_logging_target_bucket  = module.s3_bucket_logs.s3_bucket_id
  s3_bucket_server_side_encryption = "AES256"
  s3_bucket_policy_template        = "${path.module}/s3-policy-template/s3-http-deny"
  s3_bucket_policy_vars = {
    s3_bucket_arn = module.s3_bucket_ec2_codedeploy_app.s3_bucket_arn
  }
}

###################
# Cloudtrail
###################
module "s3_bucket_cloudtrail" {
  source  = "quansang/quansang/aws//modules/s3"
  version = "0.0.1"
  #basic
  env = var.env

  #s3
  name                             = "${var.project}-cloudtrail-${var.env}"
  s3_bucket_versioning             = true
  s3_bucket_logging_target_bucket  = module.s3_bucket_logs.s3_bucket_id
  s3_bucket_lifecycle_rule_days    = 730
  s3_bucket_server_side_encryption = "AES256"
  s3_bucket_policy_template        = "${path.module}/s3-policy-template/s3-cloudtrail"
  s3_bucket_policy_vars = {
    s3_bucket_id  = module.s3_bucket_cloudtrail.s3_bucket_id
    account_id    = var.account_id
    s3_bucket_arn = module.s3_bucket_cloudtrail.s3_bucket_arn
  }
}
