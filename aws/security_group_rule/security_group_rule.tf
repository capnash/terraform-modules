resource "aws_security_group_rule" "security_group_rule" {
    type = "${var.type}"
    cidr_blocks = "${var.cidrs}"
    source_security_group_id = "${var.allow_sec_group}"
    from_port = "${var.from_port}"
    to_port = "${var.to_port}"
    protocol = "${var.protocol}"
    security_group_id = "${var.sec_group}"
    self = "${var.self_allow}"
    description = "${var.description}"

    count = "${local.farm}"
}
