output "arn" {
    value = "${element(concat(aws_vpc.vpc.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_vpc.vpc.*.id,list("")),0)}"
}

output "owner" {
    value = "${element(concat(aws_vpc.vpc.*.owner_id,list("")),0)}"
}

output "default_sg" {
    value = "${element(concat(aws_vpc.vpc.*.default_security_group_id,list("")),0)}"
}

output "rtable" {
    value = "${element(concat(aws_vpc.vpc.*.main_route_table_id,list("")),0)}"
}

output "cidr" {
    value = "${element(concat(aws_vpc.vpc.*.cidr_block,list("")),0)}"
}
