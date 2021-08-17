resource "aws_codedeploy_app" "codedeploy_app" {
  name             = "${var.project}-${var.name}-${var.env}"
  compute_platform = "Server"
}
