output "arn" {
    value = "${element(concat(aws_cloudwatch_log_stream.log_stream.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_cloudwatch_log_stream.log_stream.*.name,list("")),0)}"
}
