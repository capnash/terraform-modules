resource "aws_elasticache_security_group" "cache_security_group" {
    name = "${var.caller}-${var.name}"
    description = "${var.description}"
    security_group_names = "${var.sec_grps}"

    count = "${local.farm}"
}
