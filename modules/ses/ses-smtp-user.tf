#Using SMTP to Send Email with Amazon SES
#Using condition "count" when account running Terraform don't have any permissions with IAM User
resource "aws_iam_user" "smtp_user" {
  count         = var.smtp_user_name != null ? 1 : 0
  name          = var.smtp_user_name #ses-smtp-user
  path          = "/"
  force_destroy = true

  tags = {
    Stage   = var.env
    Project = var.project
  }
}

data "template_file" "smtp_user_policy" {
  count    = var.smtp_user_name != null ? 1 : 0
  template = file("${var.smtp_user_policy_template}.json") #ses:SendRawEmail

  vars = var.smtp_user_policy_vars
}

resource "aws_iam_user_policy" "smtp_user_policy" {
  count = var.smtp_user_name != null ? 1 : 0
  name  = "AmazonSesSendingAccess-for-${aws_iam_user.smtp_user[0].name}"
  user  = aws_iam_user.smtp_user[0].name

  policy = data.template_file.smtp_user_policy[0].rendered
}

resource "aws_iam_access_key" "smtp_user_access_key" {
  count = var.smtp_user_name != null ? 1 : 0
  user  = aws_iam_user.smtp_user[0].name
}
