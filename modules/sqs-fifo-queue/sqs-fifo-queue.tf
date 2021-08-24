resource aws_sqs_queue sqs_fifo_queue {
  name                        = "${var.project}-${var.sqs_fifo_queue_type}-${var.env}.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  delay_seconds              = 0
  max_message_size           = 262144 #bytes a msg is 256 KiB
  receive_wait_time_seconds  = var.sqs_fifo_receive_wait_time_seconds     #default: setting long polling (20s)
  visibility_timeout_seconds = var.sqs_fifo_visibility_timeout_seconds
  message_retention_seconds  = var.sqs_fifo_message_retention_seconds     #default: retains a msg is 4days
  redrive_policy             = var.sqs_fifo_queue_dead_letter
}
