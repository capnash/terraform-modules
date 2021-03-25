output "id" {
    value = "${element(concat(aws_redshift_subnet_group.redshift_subnet_group.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_redshift_subnet_group.redshift_subnet_group.*.arn,list("")),0)}"
}