#modules/ec2-instance/variables.tf
#basic
variable "env" {}
variable "project" {}

#ec2-instance
variable "ami_id" {}
variable "instance_type" {}
variable "vpc_security_group_ids" {}
variable "subnet_id" {}
variable "iam_instance_profile" {}
variable "volume_size" {}
variable "user_data" { default = null }
variable "monitoring" { default = false }
variable "type" {}
