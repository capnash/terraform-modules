resource "aws_route_table_association" "route_table_association" {
    subnet_id = "${var.subnet}"
    route_table_id = "${var.rtable}"

    count = "${local.farm}"
}
