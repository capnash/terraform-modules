resource "aws_network_acl" "network_acl" {
    vpc_id = "${var.vpc}"
    subnet_ids = "${var.subnets}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
