output "id" {
    value = "${element(concat(aws_dynamodb_table.dynamodb_table.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_dynamodb_table.dynamodb_table.*.arn,list("")),0)}"
}