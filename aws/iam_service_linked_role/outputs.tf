output "id" {
    value = "${element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.name,list("")),0)}"
}

output "path" {
    value = "${element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.path,list("")),0)}"
}
