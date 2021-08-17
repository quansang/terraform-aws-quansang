resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  app_name               = var.codedeploy_app_name
  deployment_group_name  = "${var.project}-${var.type}-in-place-deployment-group-${var.env}"
  service_role_arn       = var.service_role_arn
  autoscaling_groups     = var.autoscaling_groups_name
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  dynamic "trigger_configuration" {
    for_each = var.trigger_sns_topic_name != null ? [1] : []
    content {
      trigger_events = [
        "DeploymentFailure",
        "DeploymentReady",
        "DeploymentRollback",
        "DeploymentStop",
        "DeploymentSuccess",
      ]
      trigger_name       = var.trigger_sns_topic_name
      trigger_target_arn = var.trigger_target_sns_topic_arn
    }
  }
}
