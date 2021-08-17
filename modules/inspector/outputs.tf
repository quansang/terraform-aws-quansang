#modules/inspector/outputs.tf
output "inspector_assessment_template_arn" {
  value = aws_inspector_assessment_template.inspector_assessment_template.arn
}
