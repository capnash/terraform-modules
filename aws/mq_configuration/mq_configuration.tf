resource "aws_mq_configuration" "mq_configuration" {
  name           = "${upper(var.caller)}-${var.name}"
  engine_type    = "${var.engine_type}"
  engine_version = "${var.engine_version}"
  data = "${var.data}"

  count = "${local.farm}"
}
