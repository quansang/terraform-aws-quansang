###################
# Identity
###################
resource "aws_ses_email_identity" "ses_email_identity" {
  for_each = toset(var.ses_email_address)

  email = each.value
}
