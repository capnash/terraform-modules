resource "aws_docdb_subnet_group" "docdb_subnet_group" {
    name = "${lower(var.caller)}-${lower(var.name)}"
    description = "${var.description}"
    subnet_ids = "${var.subnets}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
