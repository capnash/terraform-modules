output "id" {
    value = "${element(concat(aws_db_subnet_group.rds_subnet_group.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_db_subnet_group.rds_subnet_group.*.arn,list("")),0)}"
}
