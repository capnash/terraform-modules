output "id" {
    value = "${element(concat(aws_vpc_peering_connection_accepter.vpc_peering_connection_accepter.*.id,list("")),0)}"
}
