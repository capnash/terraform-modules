output "id" {
    value = "${element(concat(aws_route_table_association.route_table_association.*.id,list("")),0)}"
}
