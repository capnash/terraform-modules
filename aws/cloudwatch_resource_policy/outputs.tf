output "id" {
    value = "${element(concat(aws_cloudwatch_log_resource_policy.cloudwatch_resource_policy.*.id,list("")),0)}"
}