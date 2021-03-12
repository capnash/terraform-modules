resource "aws_eip_association" "eip_association" {
    allocation_id = "${var.eip}"
    instance_id = "${var.instance}"
    network_interface_id = "${var.interface}"

    count = "${local.farm}"
}