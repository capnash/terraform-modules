output "id" {
    value = "${element(concat(aws_security_group_rule.security_group_rule.*.id,list("")),0)}"
}
