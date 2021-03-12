output "arn" {
    value = "${element(concat(aws_docdb_cluster_parameter_group.docdb_parameter_group.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_docdb_cluster_parameter_group.docdb_parameter_group.*.id,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_docdb_cluster_parameter_group.docdb_parameter_group.*.name,list("")),0)}"
}
