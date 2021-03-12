output "arn" {
    value = "${element(concat(aws_iam_policy.iam_policy.*.arn,list("")),0)}"
}
