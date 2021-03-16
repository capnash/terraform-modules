output "arn" {
    value = "${element(concat(aws_subnet.subnet.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_subnet.subnet.*.id,list("")),0)}"
}
