output "arn" {
    value = "${element(concat(aws_mq_configuration.mq_configuration.*.arn,list("")),0)}"
}

output "revision" {
    value = "${element(concat(aws_mq_configuration.mq_configuration.*.latest_revision,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_mq_configuration.mq_configuration.*.id,list("")),0)}"
}
