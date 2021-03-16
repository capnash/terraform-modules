output "arn" {
    value = "${element(concat(aws_sns_topic.sns_topic.*.arn,list("")),0)}"
}
