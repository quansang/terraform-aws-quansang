#modules/kinesis-firehose/outputs.tf
output "kinesis_firehose_arn" {
  value = aws_kinesis_firehose_delivery_stream.kinesis_firehose.arn
}
