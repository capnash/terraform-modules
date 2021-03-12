resource "aws_mq_broker" "mq_broker" {
  broker_name = "${upper(var.caller)}-${var.name}"

  configuration {
    id       = "${var.configuration_id}"
    revision = "${var.configuration_revision}"
  }

  engine_type        = "${var.engine_type}"
  engine_version     = "${var.engine_version}"
  host_instance_type = "${var.engine_instance_type}"
  security_groups    = "${var.security_groups}"
  subnet_ids         = "${var.subnet_ids}"

  user {
    username = "${var.username}"
    password = "${var.password}"
    console_access = "${var.console}"
    groups = "${var.groups}"
  }

  tags = {
    Name = "${upper(var.caller)}-${var.name}"
    Description = "${var.description}"
    Environment = "${upper(var.caller)}"
    Service = "${var.svc}"
  }

  count = "${local.farm}"
}
