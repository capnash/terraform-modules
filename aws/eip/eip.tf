resource "aws_eip" "eip" {
    vpc = "${var.in_vpc}"
    public_ipv4_pool = "${var.pool}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
