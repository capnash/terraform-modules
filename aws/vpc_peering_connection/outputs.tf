output "id" {
    value = "${element(concat(aws_vpc_peering_connection.vpc_peering_connection.*.id,list("")),0)}"
}
