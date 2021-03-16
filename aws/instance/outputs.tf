output "arn" {
    value = "${element(concat(aws_instance.instance.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_instance.instance.*.id,list("")),0)}"
}

output "subnet" {
    value = "${element(concat(aws_instance.instance.*.subnet_id,list("")),0)}"
}

output "ip" {
    value = "${element(concat(aws_instance.instance.*.private_ip,list("")),0)}"
}

output "public_ip" {
    value = "${element(concat(aws_instance.instance.*.public_ip,list("")),0)}"
}
