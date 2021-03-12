output "id" {
    value = "${element(concat(aws_autoscaling_group.autoscaling_group.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_autoscaling_group.autoscaling_group.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_autoscaling_group.autoscaling_group.*.name,list("")),0)}"
}
