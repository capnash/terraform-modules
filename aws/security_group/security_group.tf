resource "aws_security_group" "security_group" {
    name = "${var.caller}-${var.name}"
    description = "${var.description}"
    revoke_rules_on_delete = "${var.revoke_all}"
    vpc_id = "${var.vpc}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
