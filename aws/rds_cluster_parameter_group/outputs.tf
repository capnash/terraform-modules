output "id" {
    value = "${element(concat(aws_rds_cluster_parameter_group.rds_cluster_parameter_group.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_rds_cluster_parameter_group.rds_cluster_parameter_group.*.arn,list("")),0)}"
}
