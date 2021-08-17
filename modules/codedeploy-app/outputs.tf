#modules/codedeploy-app/outputs.tf
output "codedeploy_app_name" {
  value = aws_codedeploy_app.codedeploy_app.name
}
