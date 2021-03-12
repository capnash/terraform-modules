resource "aws_cloudwatch_log_group" "log_group" {
    name = "${var.name}"
    retention_in_days = "${var.retention}"
    kms_key_id = "${var.key}"
    tags = {
        Name = "${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
