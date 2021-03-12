resource "aws_elasticache_subnet_group" "cache_subnet_group" {
    name = "${upper(var.caller)}-${var.name}"
    description = "${var.description}"
    subnet_ids = "${var.subnets}"

    count = "${local.farm}"
}
