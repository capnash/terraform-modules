resource "aws_cloudwatch_event_rule" "cloudwatch_rule" {
    name = "${upper(var.caller)}-${var.name}"
    schedule_expression = "${var.schedule}"
    event_pattern = "${var.event}"
    description = "${var.description}"
    role_arn = "${var.role}"
    is_enabled = "${var.enabled}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
