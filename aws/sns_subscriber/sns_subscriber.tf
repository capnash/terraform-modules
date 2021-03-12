resource "aws_sns_topic_subscription" "sns_subscriber" {
    topic_arn = "${var.inparn}"
    protocol = "${var.protocol}"
    endpoint = "${var.endpoint}"
    endpoint_auto_confirms = "${var.confirm}"

    count = "${local.farm}"
}
