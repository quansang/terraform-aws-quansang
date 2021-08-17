resource "aws_lb" "alb" {
  name                       = "${var.project}-${var.type}-alb-${var.env}"
  load_balancer_type         = "application"
  internal                   = false
  drop_invalid_header_fields = false
  enable_deletion_protection = true
  enable_http2               = true
  idle_timeout               = 60

  security_groups = var.alb_security_groups_id
  subnets         = var.alb_subnets_id

  access_logs {
    enabled = true
    bucket  = var.alb_bucket_id
  }

  tags = {
    Name    = "${var.project}-${var.type}-alb-${var.env}"
    Type    = var.type
    Stage   = var.env
    project = var.project
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.project}-${var.type}-alb-tgp-${var.env}"
  vpc_id      = var.alb_target_group_vpc_id
  target_type = var.alb_target_group_target_type

  port                          = 80
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  proxy_protocol_v2             = false
  deregistration_delay          = 300
  slow_start                    = 0
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled             = true
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    path                = var.alb_target_group_healthcheck_path
  }

  tags = {
    Name    = "${var.project}-${var.type}-alb-tgp-${var.env}"
    Type    = var.type
    Stage   = var.env
    project = var.project
  }
}
