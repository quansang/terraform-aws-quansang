#modules/sqs-fifo-queue/outputs.tf
output sqs_fifo_queue_arn {
  value = aws_sqs_queue.sqs_fifo_queue.arn
}
output sqs_fifo_queue_name {
  value = aws_sqs_queue.sqs_fifo_queue.name
}
