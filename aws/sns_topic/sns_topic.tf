resource "aws_sns_topic" "sns_topic" {
    name = "${upper(var.caller)}-${var.name}"
    delivery_policy = "${var.policy}"

    count = "${local.farm}"
}
