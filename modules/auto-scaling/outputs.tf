#modules/auto-scaling/outputs.tf
output "autoscaling_group_name" {
  value = aws_autoscaling_group.autoscaling_group.name
}
output "autoscaling_group_arn" {
  value = aws_autoscaling_group.autoscaling_group.arn
}
output "autoscaling_policy_arn" {
  value = { for key, value in aws_autoscaling_policy.autoscaling_policy : key => value.arn }
}
