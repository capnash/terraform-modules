output "id" {
    value = "${element(concat(aws_secretsmanager_secret.secret.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_secretsmanager_secret.secret.*.arn,list("")),0)}"
}