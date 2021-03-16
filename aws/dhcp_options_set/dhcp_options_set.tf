resource "aws_vpc_dhcp_options" "dhcp_options_set" {
    domain_name = "${var.dns_name}"
    domain_name_servers = "${var.dns_servers}"
    ntp_servers = "${var.ntp_servers}"
    netbios_name_servers = "${var.netns}"
    netbios_node_type = "${var.net_type}"
    tags = {
        Name = "${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
