resource "aws_autoscaling_group" "autoscaling_group" {
  name = "${var.project}-${var.type}-autoscaling-group-${var.env}"

  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = var.autoscaling_group_subnet_ids
  target_group_arns         = var.autoscaling_group_alb_target_group_arns
  health_check_type         = var.autoscaling_group_health_check_type
  health_check_grace_period = 300

  desired_capacity = var.autoscaling_group_desired_capacity
  min_size         = var.autoscaling_group_min_size
  max_size         = var.autoscaling_group_max_size

  termination_policies = var.autoscaling_group_termination_policies
  suspended_processes  = var.autoscaling_group_suspended_processes
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  tags = [
    {
      key                 = "Name"
      value               = "${var.project}-${var.type}-autoscaling-group-${var.env}"
      propagate_at_launch = true
    },
    {
      key                 = "Stage"
      value               = var.env
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.env
      propagate_at_launch = true
    },
    {
      key                 = "ServerType"
      value               = var.type
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = var.project
      propagate_at_launch = true
    }
  ]

  lifecycle {
    ignore_changes = []
  }
}

resource "aws_autoscaling_notification" "autoscaling_notification" {
  count       = var.autoscaling_notification_topic_arn != null ? 1 : 0
  group_names = [aws_autoscaling_group.autoscaling_group.name]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
  ]

  topic_arn = var.autoscaling_notification_topic_arn
}
