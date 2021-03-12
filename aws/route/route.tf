resource "aws_route" "route" {
    route_table_id = "${var.rtable}"
    destination_cidr_block = "${var.destination}"
    egress_only_gateway_id = "${var.out_gateway}"
    gateway_id = "${var.gateway}"
    instance_id = "${var.instance}"
    nat_gateway_id = "${var.nat}"
    network_interface_id = "${var.nic}"
    transit_gateway_id = "${var.transit_gw}"
    vpc_peering_connection_id = "${var.vpc_peer}"

    count = "${local.farm}"
}
