output "id" {
    value = "${element(concat(aws_eip.eip.*.id,list("")),0)}"
}

output "ip" {
    value = "${element(concat(aws_eip.eip.*.public_ip,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_eip.eip.*.public_dns,list("")),0)}"
}

output "interface" {
    value = "${element(concat(aws_eip.eip.*.network_interface,list("")),0)}"
}