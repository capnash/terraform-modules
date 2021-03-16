output "id" {
    value = "${element(concat(aws_network_acl.network_acl.*.id,list("")),0)}"
}
