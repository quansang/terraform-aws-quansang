#modules/ecs/variables.tf
#base
variable env {}
variable project {}
variable profile {}
variable region {}

#ecs-service
variable ecs_service_cluster_id {}
variable ecs_service_security_groups_id {}
variable ecs_service_subnets_id {}
variable ecs_service_target_group_arn {}

variable ecs_service_name {}
variable ecs_service_desired_count {}
variable ecs_service_deployment_maximum_percent {}
variable ecs_service_deployment_minimum_healthy_percent {}
variable ecs_service_container_name {}
variable ecs_service_container_port {}

#ecs-task-definition
variable ecs_task_definition_template {}
variable ecs_task_definition_vars {}

variable ecs_task_definition_name {}
variable ecs_task_definition_total_memory {}
variable ecs_task_definition_total_cpu {}
variable ecs_task_definition_execution_role_arn {}
variable ecs_task_definition_task_role_arn {}
variable ecs_task_definition_volume_name { default = null }
variable ecs_task_definition_type {}



