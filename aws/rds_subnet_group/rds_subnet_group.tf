resource "aws_db_subnet_group" "rds_subnet_group" {
    name = "${lower(var.caller)}-${lower(var.name)}"
    description = "${var.description}"
    subnet_ids = "${var.subnets}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
