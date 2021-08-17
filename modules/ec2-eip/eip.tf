resource "aws_eip" "ec2_eip" {
  vpc      = true
  instance = var.ec2_instance_id
  tags = {
    Name    = "${var.project}-eip-${var.type}-${var.env}"
    Type    = var.type
    Stage   = var.env
    Project = var.project
  }
}
