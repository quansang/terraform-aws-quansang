resource "aws_ssm_parameter" "ssm_parameter" {
  name      = var.ssm_parameter_name
  value     = var.ssm_parameter_value
  key_id    = var.kms_key_arn
  type      = "SecureString"
  overwrite = "true"

  tags = {
    Stage   = var.env
    Project = var.project
  }
}
