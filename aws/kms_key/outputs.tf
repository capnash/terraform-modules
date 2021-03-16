output "arn" {
    value = "${element(concat(aws_kms_key.kms_key.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_kms_key.kms_key.*.key_id,list("")),0)}"
}