data "aws_caller_identity" "current" {}

# Check if ami exist
data "external" "check_ami_exists" {
  program = ["/bin/bash", "${path.module}/check_ami_exists.sh",
    "${var.project}-${var.env}",
    data.aws_caller_identity.current.account_id,
    var.project,
    var.ec2_ami_type,
    var.env,
  ]
}

data "aws_ami" "ec2_ami" {
  count = data.external.check_ami_exists.result.ami_exists == "exist" ? 1 : 0

  most_recent = true
  name_regex  = "^${var.project}-*"
  owners      = [data.aws_caller_identity.current.account_id]

  filter {
    name   = "name"
    values = ["${var.project}-*"]
  }

  filter {
    name   = "tag:Type"
    values = [var.ec2_ami_type]
  }

  filter {
    name   = "tag:Environment"
    values = [var.env]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
