resource "aws_config_configuration_recorder" "configuration_recorder" {
  name     = "${var.project}-aws-config-${var.env}"
  role_arn = var.configuration_recorder_role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_configuration_recorder_status" "configuration_recorder_status" {
  name       = aws_config_configuration_recorder.configuration_recorder.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.delivery_channel]
}

resource "aws_config_delivery_channel" "delivery_channel" {
  name           = aws_config_configuration_recorder.configuration_recorder.name
  s3_bucket_name = var.delivery_channel_s3_bucket_name
  sns_topic_arn  = var.delivery_channel_sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = "Three_Hours"
  }
}




