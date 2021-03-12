output "arn" {
    value = "${element(concat(aws_security_group.security_group.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_security_group.security_group.*.id,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_security_group.security_group.*.name,list("")),0)}"
}
