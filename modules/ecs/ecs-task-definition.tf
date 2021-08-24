data template_file ecs_task_definition {
  template = file("${var.ecs_task_definition_template}.json")
  vars     = var.ecs_task_definition_vars
}

# Create task definition
resource aws_ecs_task_definition ecs_task_definition {
  family                   = "${var.project}-${var.ecs_task_definition_name}-task-definition-${var.env}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = var.ecs_task_definition_total_memory
  cpu                      = var.ecs_task_definition_total_cpu
  execution_role_arn       = var.ecs_task_definition_execution_role_arn
  task_role_arn            = var.ecs_task_definition_task_role_arn
  container_definitions    = data.template_file.ecs_task_definition.rendered

  dynamic volume {
    for_each = var.ecs_task_definition_volume_name != null ? [1] : []
    content {
      name = var.ecs_task_definition_volume_name
    }
  }

  tags = {
    Name  = "${var.project}-${var.ecs_task_definition_name}-task-definition-${var.env}"
    Type  = var.ecs_task_definition_type
    Stage = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}
