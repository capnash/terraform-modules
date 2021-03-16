resource "aws_secretsmanager_secret" "secret" {
    name = "${var.name}"
    description = "${var.description}"
    kms_key_id = "${var.kms}"
    policy = "${var.policy}"
    recovery_window_in_days = "${var.recovery_days}"
    tags = {
        Name = "${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
