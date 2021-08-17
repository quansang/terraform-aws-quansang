#modules/codedeploy-inplace-deployment-group/outputs.tf
output "codedeploy_deployment_group_name" {
  value = aws_codedeploy_deployment_group.codedeploy_deployment_group.*.deployment_group_name
}

