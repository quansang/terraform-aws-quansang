resource "aws_inspector_resource_group" "inspector_resource_group" {
  tags = var.inspector_resource_group_tags
}

resource "aws_inspector_assessment_target" "inspector_assessment_target" {
  name               = "${var.project}-Assessment-Target-${var.inspector_assessment_target_name}-${var.env}"
  resource_group_arn = aws_inspector_resource_group.inspector_resource_group.arn
}

resource "aws_inspector_assessment_template" "inspector_assessment_template" {
  name       = "${var.project}-Assessment-Template-${var.inspector_assessment_template_name}-${var.env}"
  target_arn = aws_inspector_assessment_target.inspector_assessment_target.arn
  duration   = 3600

  rules_package_arns = var.inspector_assessment_template_rules_package_arns
}

resource "null_resource" "inspector_assessment_template_event" {
  provisioner "local-exec" {
    when        = create
    command     = <<EOF
set -e
aws inspector subscribe-to-event --event ASSESSMENT_RUN_STARTED --resource-arn ${aws_inspector_assessment_template.inspector_assessment_template.arn} --topic-arn ${var.inspector_assessment_template_sns_topic_arn} --region ${var.region} --profile ${var.profile}
aws inspector subscribe-to-event --event ASSESSMENT_RUN_COMPLETED --resource-arn ${aws_inspector_assessment_template.inspector_assessment_template.arn} --topic-arn ${var.inspector_assessment_template_sns_topic_arn} --region ${var.region} --profile ${var.profile}
EOF
    interpreter = ["/bin/bash", "-c"]
  }
  triggers = {
    resource_arn = aws_inspector_assessment_template.inspector_assessment_template.arn
    topic_arn    = var.inspector_assessment_template_sns_topic_arn
  }
}
