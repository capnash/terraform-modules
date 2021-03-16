resource "aws_vpc_peering_connection" "vpc_peering_connection" {
    peer_owner_id = "${var.peer_owner}"
    peer_vpc_id = "${var.peer_vpc}"
    vpc_id = "${var.vpc}"
    auto_accept = "${var.auto_accept}"
    peer_region = "${var.peer_region}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
