output "id" {
    value = "${element(concat(aws_iam_role.iam_role.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_iam_role.iam_role.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_iam_role.iam_role.*.name,list("")),0)}"
}
