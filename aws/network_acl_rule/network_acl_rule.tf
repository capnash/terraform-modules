resource "aws_network_acl_rule" "network_acl_rule" {
    network_acl_id = "${var.acl}"
    rule_number = "${var.priority}"
    egress = "${var.outgoing}"
    protocol = "${var.protocol}"
    rule_action = "${var.action}"
    cidr_block = "${var.cidr}"
    from_port = "${var.from}"
    to_port = "${var.to}"
    icmp_type = "${var.icmp_type}"
    icmp_code = "${var.icmp_code}"

    count = "${local.farm}"
}
