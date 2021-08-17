#IAM Assume Role
data "template_file" "iam_assume_role_template" {
  template = file("${var.iam_assume_role_template}.json")
}

#Role
resource "aws_iam_role" "iam_role" {
  name               = "${var.project}-${var.name}-role-${var.env}"
  assume_role_policy = data.template_file.iam_assume_role_template.template
  description        = "${var.env}: ${var.service}"

  tags = {
    Stage = var.env
    Type  = var.type
  }
}

#IAM Default Policy
resource "aws_iam_policy_attachment" "default_policy" {
  count      = var.default_policy_arn != null ? length(var.default_policy_arn) : 0
  name       = "${var.project}-${var.name}-default-policy-${var.env}"
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = element(var.default_policy_arn, count.index)
}

#IAM Policy
data "template_file" "iam_policy_template" {
  count    = var.iam_policy_template != null ? 1 : 0
  template = file("${var.iam_policy_template}.json")
  vars     = var.iam_policy_vars
}

resource "aws_iam_role_policy" "iam_policy" {
  count  = var.iam_policy_template != null ? 1 : 0
  name   = "${var.project}-${var.name}-policy-${var.env}"
  role   = aws_iam_role.iam_role.id
  policy = data.template_file.iam_policy_template[0].rendered
}

#Instance Profile
resource "aws_iam_instance_profile" "iam_instance_profile" {
  count = var.iam_instance_profile == true ? 1 : 0
  name  = "${var.project}-${var.name}-instance-profile-${var.env}"
  role  = aws_iam_role.iam_role.name
}
