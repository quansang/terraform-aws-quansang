# Refer https://docs.aws.amazon.com/systems-manager/latest/userguide/reference-cron-and-rate-expressions.html
resource "aws_ssm_maintenance_window" "scan_window" {
  name              = "${var.project}-maintenance-window-application-${var.env}"
  schedule          = "cron(0 1 1 * ? *)"
  schedule_timezone = "Asia/Tokyo"
  duration          = 3
  cutoff            = 1

  tags = {
    Stage   = var.env
    Type    = "ssm-scan"
    Project = var.project
  }
}

resource "aws_ssm_maintenance_window_target" "scan_window_target" {
  for_each = var.scan_window_target_ServerType

  window_id     = aws_ssm_maintenance_window.scan_window.id
  resource_type = "INSTANCE"

  targets {
    key    = "tag:ServerType"
    values = [each.value]
  }
  targets {
    key    = "tag:Environment"
    values = [var.env]
  }
  targets {
    key    = "tag:Project"
    values = [var.project]
  }
}

resource "aws_ssm_maintenance_window_task" "scan_window_task" {
  window_id        = aws_ssm_maintenance_window.scan_window.id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = var.scan_window_task_role_arn
  max_concurrency  = 50
  max_errors       = 0

  targets {
    key    = "WindowTargetIds"
    values = values(aws_ssm_maintenance_window_target.scan_window_target)[*].id
  }

  task_invocation_parameters {
    run_command_parameters {
      service_role_arn = var.scan_window_task_role_arn
      timeout_seconds  = 600

      dynamic "notification_config" {
        for_each = var.scan_window_task_notification_arn != null ? [1] : []
        content {
          notification_arn    = var.scan_window_task_notification_arn
          notification_events = ["Success", "Failed", "Cancelled"]
          notification_type   = "Command"
        }
      }

      parameter {
        name   = "Operation"
        values = ["Scan"]
      }

      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }
    }
  }
}
