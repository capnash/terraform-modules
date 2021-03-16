output "eip" {
    value = "${element(concat(aws_eip_association.eip_association.*.allocation_id,list("")),0)}"
}

output "instance" {
    value = "${element(concat(aws_eip_association.eip_association.*.instance_id,list("")),0)}"
}

output "ip" {
    value = "${element(concat(aws_eip_association.eip_association.*.public_ip,list("")),0)}"
}