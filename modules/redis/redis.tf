data "aws_availability_zones" "available" {}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name        = "${var.project}-redis-subnet-group-${var.env}"
  description = "${var.project}-redis-subnet-group-${var.env} for the redis instances"
  subnet_ids  = var.redis_subnet_id
}

resource "aws_elasticache_replication_group" "redis_replication_group" {
  automatic_failover_enabled = var.redis_automatic_failover_enabled
  multi_az_enabled           = var.redis_multi_az_enabled

  replication_group_id          = "${var.project}-redis-repl-group-${var.env}"
  replication_group_description = "ElastiCache with redis for ${var.project} ${var.env}"

  node_type             = var.redis_node_type
  number_cache_clusters = var.redis_number_cache_clusters
  parameter_group_name  = var.redis_parameter_group_name
  engine_version        = var.redis_engine_version
  security_group_ids    = [var.redis_security_group_ids]
  subnet_group_name     = aws_elasticache_subnet_group.redis_subnet_group.name

  maintenance_window         = "sun:16:00-sun:17:00"
  snapshot_window            = "17:01-18:01"
  snapshot_retention_limit   = 7
  apply_immediately          = true
  auto_minor_version_upgrade = false
  port                       = "6379"

  notification_topic_arn = var.redis_sns_topic_arn #If notification topic status is inactive, active it

  tags = {
    Name  = "${var.project}-redis-node-${var.env}"
    Stage = var.env
  }
}
