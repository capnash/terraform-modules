output "arn" {
    value = "${element(concat(aws_sqs_queue.sqs_queue.*.arn,list("")),0)}"
}