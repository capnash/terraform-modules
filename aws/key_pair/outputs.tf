output "name" {
    value = "${element(concat(aws_key_pair.key_pair.*.key_name,list("")),0)}"
}
