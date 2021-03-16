output "id" {
    value = "${element(concat(aws_docdb_subnet_group.docdb_subnet_group.*.arn,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_docdb_subnet_group.docdb_subnet_group.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_docdb_subnet_group.docdb_subnet_group.*.name,list("")),0)}"
}
