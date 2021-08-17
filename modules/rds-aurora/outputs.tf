#modules/rds-aurora/outputs.tf
output "aurora_cluster_name" {
  value = aws_rds_cluster.aurora_cluster.database_name
}
output "aurora_cluster_identifier" {
  value = aws_rds_cluster.aurora_cluster.cluster_identifier
}
output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}
output "aurora_cluster_reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}
output "aurora_cluster_instance_endpoint" {
  value = aws_rds_cluster_instance.aurora_cluster_instance.*.endpoint
}
output "aurora_cluster_instance_identifier" {
  value = aws_rds_cluster_instance.aurora_cluster_instance[0].identifier
}
output "aurora_cluster_master_username" {
  value = aws_rds_cluster.aurora_cluster.master_username
}
