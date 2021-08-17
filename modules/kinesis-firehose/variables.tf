#modules/kinesis-firehose/variables.tf
#basic
variable "env" {}
variable "project" {}

#kinesis-firehose
variable "service" {}
variable "type" {}
variable "s3_configuration_iam_role_arn" {}
variable "s3_configuration_bucket_arn" {}
