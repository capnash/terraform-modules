output "id" {
    value = "${element(concat(aws_kinesis_stream.kinesis_data_stream.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_kinesis_stream.kinesis_data_stream.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_kinesis_stream.kinesis_data_stream.*.name,list("")),0)}"
}
