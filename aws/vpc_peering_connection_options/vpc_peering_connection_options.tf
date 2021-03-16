resource "aws_vpc_peering_connection_options" "vpc_peering_connection_options" {
    vpc_peering_connection_id = "${var.vpc_peering_conn}"
    dynamic "accepter" {
        for_each = [for key in var.accepter: {
            map = merge(local.defaults.accepter,key)
        }]
        content {
            allow_remote_vpc_dns_resolution = accepter.value.map.allow_remote_vpc_dns_resolution
            allow_classic_link_to_remote_vpc = accepter.value.map.allow_classic_link_to_remote_vpc
            allow_vpc_to_remote_classic_link = accepter.value.map.allow_vpc_to_remote_classic_link
        }
    }
    dynamic "requester" {
        for_each = [for key in var.requester: {
            map = merge(local.defaults.accepter,key)
        }]
        content {
            allow_remote_vpc_dns_resolution = requester.value.map.allow_remote_vpc_dns_resolution
            allow_classic_link_to_remote_vpc = requester.value.map.allow_classic_link_to_remote_vpc
            allow_vpc_to_remote_classic_link = requester.value.map.allow_vpc_to_remote_classic_link
        }
    }

    count = "${local.farm}"
}
