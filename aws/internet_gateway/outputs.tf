output "id" {
    value = "${element(concat(aws_internet_gateway.internet_gateway.*.id,list("")),0)}"
}
