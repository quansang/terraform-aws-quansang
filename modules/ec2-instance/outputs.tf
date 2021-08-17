#modules/ec2-instance/outputs.tf
output "ec2_instance_id" {
  value = aws_instance.ec2_instance.id
}
