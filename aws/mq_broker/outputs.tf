output "arn" {
    value = "${element(concat(aws_mq_broker.mq_broker.*.arn,list("")),0)}"
}

output "ssl_endpoint" {
    value = "${element(concat(aws_mq_broker.mq_broker.*.instances.0.endpoints.0,list("")),0)}"
}
