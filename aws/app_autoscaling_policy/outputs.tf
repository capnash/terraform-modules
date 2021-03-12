output "arn" {
    value = "${element(concat(aws_appautoscaling_policy.app_autoscaling_policy.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_appautoscaling_policy.app_autoscaling_policy.*.name,list("")),0)}"
}

output "policy_type" {
    value = "${element(concat(aws_appautoscaling_policy.app_autoscaling_policy.*.policy_type,list("")),0)}"
}