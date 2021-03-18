resource "aws_cloudwatch_log_stream" "log_stream" {
    name = "${var.caller}-${var.name}"
    log_group_name = "${var.log_group}"

    count = "${local.farm}"
}
