output "id" {
    value = "${element(concat(aws_nat_gateway.nat_gateway.*.id,list("")),0)}"
}

output "eip" {
    value = "${element(concat(aws_nat_gateway.nat_gateway.*.public_ip,list("")),0)}"
}

output "ip" {
    value = "${element(concat(aws_nat_gateway.nat_gateway.*.private_ip,list("")),0)}"
}
