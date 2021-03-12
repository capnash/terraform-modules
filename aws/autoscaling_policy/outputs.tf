output "arn" {
    value = "${element(concat(aws_autoscaling_policy.autoscaling_policy.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_autoscaling_policy.autoscaling_policy.*.name,list("")),0)}"
}