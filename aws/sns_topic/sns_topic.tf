resource "aws_sns_topic" "sns_topic" {
    name = "${var.caller}-${var.name}"
    delivery_policy = "${var.policy}"

    count = "${local.farm}"
}
