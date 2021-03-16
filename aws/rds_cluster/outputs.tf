output "id" {
    value = "${element(concat(aws_rds_cluster.rds_cluster.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_rds_cluster.rds_cluster.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_rds_cluster.rds_cluster.*.cluster_identifier,list("")),0)}"
}

output "dns" {
    value = "${element(concat(aws_rds_cluster.rds_cluster.*.endpoint,list("")),0)}"
}

output "port" {
    value = "${element(concat(aws_rds_cluster.rds_cluster.*.port,list("")),0)}"
}
