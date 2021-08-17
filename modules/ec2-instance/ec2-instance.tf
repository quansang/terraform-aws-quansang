# Need to create key-pair on AWS Console
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "${var.project}-keypair-${var.env}"

  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id              = var.subnet_id
  iam_instance_profile   = var.iam_instance_profile

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.volume_size
    delete_on_termination = true
  }
  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = false
  user_data               = var.user_data
  monitoring              = var.monitoring

  tags = {
    Name        = "${var.project}-ec2-${var.type}-instance-${var.env}"
    Environment = var.env
    ServerType  = var.type
    Stage       = var.env
    Project     = var.project
  }

  lifecycle {
    create_before_destroy = true
  }
}
