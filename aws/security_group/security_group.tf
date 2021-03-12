resource "aws_security_group" "security_group" {
    name = "${upper(var.caller)}-${var.name}"
    description = "${var.description}"
    revoke_rules_on_delete = "${var.revoke_all}"
    vpc_id = "${var.vpc}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
