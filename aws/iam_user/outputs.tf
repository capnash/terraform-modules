output "arn" {
    value = "${element(concat(aws_iam_user.iam_user.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_iam_user.iam_user.*.name,list("")),0)}"
}
