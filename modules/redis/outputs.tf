#modules/redis/variables.tf
output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.redis_replication_group.primary_endpoint_address
}
output "member_clusters" {
  value = tolist(aws_elasticache_replication_group.redis_replication_group.*.member_clusters[0])
}
output "cluster_id" {
  value = aws_elasticache_replication_group.redis_replication_group.id
}
