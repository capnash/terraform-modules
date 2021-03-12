output "arn" {
    value = "${element(concat(aws_ssm_parameter.ssm_parameter.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_ssm_parameter.ssm_parameter.*.name,list("")),0)}"
}
