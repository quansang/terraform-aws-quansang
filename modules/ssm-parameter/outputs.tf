#modules/ssm-parameter/outputs.tf
output "ssm_parameter_name" {
  value = aws_ssm_parameter.ssm_parameter.name
}

output "ssm_parameter_value" {
  value = aws_ssm_parameter.ssm_parameter.value
}
