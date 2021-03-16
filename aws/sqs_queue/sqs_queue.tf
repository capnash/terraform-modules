resource "aws_sqs_queue" "sqs_queue" {
    name = "${var.caller}-${var.name}"
    visibility_timeout_seconds = "${var.visible_timeout}"
    message_retention_seconds = "${var.retention}"
    max_message_size = "${var.message_size}"
    delay_seconds = "${var.delay}"
    receive_wait_time_seconds = "${var.wait_time}"
    policy = "${var.policy}"
    redrive_policy = "${var.redrive}"
    fifo_queue = "${var.fifo}"
    content_based_deduplication = "${var.dedupe}"
    kms_master_key_id = "${var.master_key}"
    kms_data_key_reuse_period_seconds = "${var.key_reuse_time}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
