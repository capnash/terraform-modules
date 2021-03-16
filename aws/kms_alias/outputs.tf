output "arn" {
    value = "${element(concat(aws_kms_alias.kms_alias.*.arn,list("")),0)}"
}

output "key" {
    value = "${element(concat(aws_kms_alias.kms_alias.*.target_key_arn,list("")),0)}"
}