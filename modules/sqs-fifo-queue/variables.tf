#modules/sqs-fifo-queue/variables.tf
#base
variable env {}
variable project {}
#sqs-fifo-queue
variable sqs_fifo_queue_type {}
variable sqs_fifo_queue_dead_letter { default = null }
variable sqs_fifo_visibility_timeout_seconds { default = 7200 }
variable sqs_fifo_receive_wait_time_seconds { default = 20 }
variable sqs_fifo_message_retention_seconds { default = 345600 }
