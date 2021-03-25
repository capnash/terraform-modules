output "id" {
    value = "${element(concat(aws_redshift_parameter_group.redshift_parameter_group.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_redshift_parameter_group.redshift_parameter_group.*.arn,list("")),0)}"
}