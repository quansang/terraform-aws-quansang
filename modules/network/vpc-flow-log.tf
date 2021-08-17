resource "aws_flow_log" "vpc_flow_log" {
  count                    = var.vpc_flow_log_s3_bucket_arn != null ? 1 : 0
  log_destination          = var.vpc_flow_log_s3_bucket_arn
  log_destination_type     = "s3"
  traffic_type             = "ALL"
  vpc_id                   = aws_vpc.vpc.id
  max_aggregation_interval = 600

  tags = {
    Name  = "${var.project}-vpc-flow-log-${var.env}"
    Stage = var.env
  }
}
