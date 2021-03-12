resource "aws_kms_key" "kms_key" {
    description = "${var.name}"
    key_usage = "${var.usage}"
    policy = "${var.policy}"
    deletion_window_in_days = "${var.delete_time}"
    is_enabled = "${var.enabled}"
    enable_key_rotation = "${var.rotate}"
    tags = {
        Name = "${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
