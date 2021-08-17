resource "aws_launch_configuration" "launch_config" {
  name_prefix = "${var.project}-${var.type}-launch-config-${var.env}-"

  key_name             = "${var.project}-keypair-${var.env}"
  image_id             = var.launch_config_ami_id
  instance_type        = var.launch_config_instance_type
  security_groups      = var.launch_config_security_groups_id
  iam_instance_profile = var.launch_config_iam_instance_profile

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.launch_config_volume_size
    delete_on_termination = true
  }

  user_data         = var.launch_config_user_data
  enable_monitoring = var.launch_config_enable_monitoring
  ebs_optimized     = false

  lifecycle {
    create_before_destroy = true
  }
}
