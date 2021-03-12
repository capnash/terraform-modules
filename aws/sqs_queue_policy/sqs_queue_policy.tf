resource "aws_sqs_queue_policy" "sqs_queue_policy" {
    queue_url = "${var.queue}"
    policy = "${var.q_policy}"

    count = "${local.farm}"
}