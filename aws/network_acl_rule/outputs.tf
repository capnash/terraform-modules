output "id" {
    value = "${element(concat(aws_network_acl_rule.network_acl_rule.*.id,list("")),0)}"
}
