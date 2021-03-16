output "id" {
    value = "${element(concat(aws_docdb_cluster.docdb_cluster.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_docdb_cluster.docdb_cluster.*.arn,list("")),0)}"
}

output "dns" {
    value = "${element(concat(aws_docdb_cluster.docdb_cluster.*.endpoint,list("")),0)}"
}

output "port" {
    value = "${element(concat(aws_docdb_cluster.docdb_cluster.*.port,list("")),0)}"
}
