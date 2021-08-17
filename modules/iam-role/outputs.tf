#modules/iam-role/outputs.tf
output "iam_role_arn" {
  value = aws_iam_role.iam_role.arn
}
output "iam_instance_profile_id" {
  value = var.iam_instance_profile == true ? aws_iam_instance_profile.iam_instance_profile[0].id : 0
}

output "iam_instance_profile_arn" {
  value = var.iam_instance_profile == true ? aws_iam_instance_profile.iam_instance_profile[0].arn : 0
}
