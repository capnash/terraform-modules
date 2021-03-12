output "id" {
    value = "${element(concat(aws_secretsmanager_secret_version.secret_version.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_secretsmanager_secret_version.secret_version.*.arn,list("")),0)}"
}

output "version" {
    value = "${element(concat(aws_secretsmanager_secret_version.secret_version.*.version_id,list("")),0)}"
}
