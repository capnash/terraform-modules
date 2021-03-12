resource "aws_ssm_parameter" "ssm_parameter" {
    name = "/${var.name}"
    description = "${var.description}"
    type = "${var.type}"
    value = "${var.value}"
    tier = "${var.tier}"
    key_id = "${var.kms}"
    overwrite = "${var.overwrite}"
    allowed_pattern = "${var.pattern}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
