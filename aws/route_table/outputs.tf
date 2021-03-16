output "id" {
    value = "${element(concat(aws_route_table.route_table.*.id,list("")),0)}"
}
