resource "aws_autoscaling_policy" "autoscaling_policy" {
  for_each = var.autoscaling_policy

  name                     = "${var.project}-${var.type}-${each.value["scale_type"]}-policy-${var.env}"
  autoscaling_group_name   = aws_autoscaling_group.autoscaling_group.name
  policy_type              = "SimpleScaling"
  adjustment_type          = each.value["adjustment_type"]
  min_adjustment_magnitude = each.value["adjustment_type"] == "PercentChangeInCapacity" ? 1 : null #Minimum value to scale by when adjustment_type is set to PercentChangeInCapacity
  scaling_adjustment       = each.value["scaling_adjustment"]
  cooldown                 = each.value["cooldown"]
}

