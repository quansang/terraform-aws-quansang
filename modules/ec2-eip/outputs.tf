#modules/ec2-eip/outputs.tf
output "ec2_eip_public_ip" {
  value = aws_eip.ec2_eip.public_ip
}
