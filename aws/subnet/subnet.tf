resource "aws_subnet" "subnet" {
    vpc_id = "${var.vpc}"
    availability_zone = "${var.a_z}"
    cidr_block = "${var.cidr}"
    map_public_ip_on_launch = "${var.default_public}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Environment = "${upper(var.caller)}"
        Description = "${var.description}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
