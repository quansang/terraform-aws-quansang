#modules/ses/outputs.tf
output "ses_smtp_password_v4" {
  value = var.smtp_user_name != null ? aws_iam_access_key.smtp_user_access_key[0].ses_smtp_password_v4 : "Don't have full permission with IAM Service"
}
