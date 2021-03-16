resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = "${var.nat_eip}"
    subnet_id = "${var.subnet}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
