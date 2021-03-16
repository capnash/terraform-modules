output "arn" {
    value = "${element(concat(aws_docdb_cluster_instance.docdb_instance.*.arn,list("")),0)}"
}

output "dns" {
    value = "${element(concat(aws_docdb_cluster_instance.docdb_instance.*.endpoint,list("")),0)}"
}
