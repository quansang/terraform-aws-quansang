#modules/athena/outputs.tf
output "athena_database_name" {
  value = aws_athena_database.athena_database.id
}

output "athena_workgroup_name" {
  value = { for key, value in aws_athena_workgroup.athena_workgroup : key => value.id }
}

output "athena_workgroup_arn" {
  value = { for key, value in aws_athena_workgroup.athena_workgroup : key => value.arn }
}
