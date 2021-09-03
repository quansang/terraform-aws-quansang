resource aws_ecs_service ecs_service {
  name                 = "${var.project}-${var.ecs_service_name}-ecs-fargate-${var.env}"
  cluster              = var.ecs_service_cluster_id
  task_definition      = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count        = var.ecs_service_desired_count
  launch_type          = "FARGATE"
  platform_version     = "LATEST"
  force_new_deployment = false

  deployment_maximum_percent         = var.ecs_service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_service_deployment_minimum_healthy_percent
  health_check_grace_period_seconds  = "120"

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.ecs_service_security_groups_id]
    subnets          = var.ecs_service_subnets_id
  }

  load_balancer {
    target_group_arn = var.ecs_service_target_group_arn
    container_name   = "${var.project}-${var.ecs_service_container_name}-container-${var.env}"
    container_port   = var.ecs_service_container_port
  }

  deployment_controller {
    type = "ECS"
  }
}
