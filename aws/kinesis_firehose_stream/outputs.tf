output "arn" {
    value = "${element(concat(aws_kinesis_firehose_delivery_stream.kinesis_firehose.*.arn,list("")),0)}"
}