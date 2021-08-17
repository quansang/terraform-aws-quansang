resource "aws_db_subnet_group" "aurora_subnet_group" {
  name        = "${var.project}-${var.aurora_database_engine}-subnet-group-${var.env}"
  subnet_ids  = var.aurora_subnet_id
  description = "${var.project}-${var.aurora_database_engine}-subnet-group-${var.env} for private subnet"

  tags = {
    Name  = "${var.project}-${var.aurora_database_engine}-subnet-group-${var.env}"
    Stage = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
  name        = "${var.project}-${var.aurora_database_engine}-parameter-group-${var.env}"
  family      = var.aurora_family
  description = "${var.project} parameter group for ${var.aurora_family}-${var.env}"

  dynamic "parameter" {
    for_each = var.aurora_db_instance_parameters

    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true #To recreate parameter group
  }
}

resource "aws_rds_cluster_parameter_group" "aurora_rds_cluster_parameter_group" {
  name        = "${var.project}-${var.aurora_database_engine}-cluster-parameter-group-${var.env}"
  family      = var.aurora_family
  description = "${var.project} cluster parameter group for ${var.aurora_family}-${var.env}"

  dynamic "parameter" {
    for_each = var.aurora_cluster_parameters

    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  lifecycle {
    create_before_destroy = true #To recreate cluster parameter group
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = "${var.project}-${var.aurora_database_engine}-cluster-${var.env}"
  engine             = var.aurora_database_engine
  engine_version     = var.aurora_cluster_engine_version
  database_name      = "${var.project}${var.env}"
  master_username    = "${var.project}admin${var.env}"
  master_password    = var.aurora_cluster_master_password

  final_snapshot_identifier    = "final-snapshot-${var.aurora_database_engine}-cluster-${var.project}-${var.env}"
  backup_retention_period      = 7
  preferred_backup_window      = "17:01-17:31"
  preferred_maintenance_window = "sun:16:00-sun:17:00"

  vpc_security_group_ids          = [var.aurora_cluster_vpc_security_group_ids]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_rds_cluster_parameter_group.name
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnet_group.id
  port                            = "3306"
  skip_final_snapshot             = false
  apply_immediately               = true
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  kms_key_id        = var.aurora_cluster_kms_key_id
  storage_encrypted = true
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  count                        = var.aurora_instance_count
  engine                       = aws_rds_cluster.aurora_cluster.engine
  engine_version               = aws_rds_cluster.aurora_cluster.engine_version
  cluster_identifier           = aws_rds_cluster.aurora_cluster.id
  identifier                   = "${var.project}-${var.env}-${count.index}"
  instance_class               = "db.${var.aurora_instance_class}"
  db_parameter_group_name      = aws_db_parameter_group.aurora_parameter_group.name
  apply_immediately            = true
  db_subnet_group_name         = aws_db_subnet_group.aurora_subnet_group.id
  auto_minor_version_upgrade   = false
  performance_insights_enabled = false
  publicly_accessible          = false
  monitoring_role_arn          = var.aurora_instance_monitoring_role_arn
  monitoring_interval          = var.aurora_instnace_monitoring_interval

  tags = {
    Name  = "${var.project}-${var.aurora_database_engine}-instance-${var.env}"
    Stage = var.env
  }
}

resource "aws_db_event_subscription" "aurora_cluster_events" {
  count     = var.aurora_cluster_event_sns_topic_arn != null ? 1 : 0
  name      = "${var.project}-${var.aurora_database_engine}-cluster-events-${var.env}"
  sns_topic = var.aurora_cluster_event_sns_topic_arn

  source_type = "db-cluster"
  source_ids  = [aws_rds_cluster.aurora_cluster.id]

  event_categories = [
    "failover",
    "failure",
    "maintenance",
    "notification",
  ]
}
