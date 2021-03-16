output "id" {
    value = "${element(concat(aws_db_parameter_group.rds_instance_parameter_group.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_db_parameter_group.rds_instance_parameter_group.*.arn,list("")),0)}"
}
