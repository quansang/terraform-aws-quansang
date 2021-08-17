#modules/ec2-get-ami/outputs.tf
output "check_ami_exists_result" {
  value = data.external.check_ami_exists.result.ami_exists
}
output "ec2_ami_id" {
  value = data.external.check_ami_exists.result.ami_exists == "exist" ? join("", data.aws_ami.ec2_ami.*.id) : 0
}
