output "id" {
    value = "${element(concat(aws_cloudwatch_event_rule.cloudwatch_rule.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_cloudwatch_event_rule.cloudwatch_rule.*.arn,list("")),0)}"
}
