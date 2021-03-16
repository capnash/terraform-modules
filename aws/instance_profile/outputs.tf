output "id" {
    value = "${element(concat(aws_iam_instance_profile.instance_profile.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_iam_instance_profile.instance_profile.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_iam_instance_profile.instance_profile.*.name,list("")),0)}"
}

output "role" {
    value = "${element(concat(aws_iam_instance_profile.instance_profile.*.role,list("")),0)}"
}
