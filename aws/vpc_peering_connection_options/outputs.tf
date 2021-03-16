output "id" {
    value = "${element(concat(aws_vpc_peering_connection_options.vpc_peering_connection_options.*.id,list("")),0)}"
}
