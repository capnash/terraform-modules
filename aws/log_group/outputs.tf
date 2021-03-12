output "arn" {
    value = "${element(concat(aws_cloudwatch_log_group.log_group.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_cloudwatch_log_group.log_group.*.name,list("")),0)}"
}
