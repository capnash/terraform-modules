output "id" {
    value = "${element(concat(aws_rds_cluster_instance.rds_instance.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_rds_cluster_instance.rds_instance.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_rds_cluster_instance.rds_instance.*.identifier,list("")),0)}"
}

output "cluster" {
    value = "${element(concat(aws_rds_cluster_instance.rds_instance.*.cluster_identifier,list("")),0)}"
}

output "dns" {
    value = "${element(concat(aws_rds_cluster_instance.rds_instance.*.endpoint,list("")),0)}"
}

output "port" {
    value = "${element(concat(aws_rds_cluster_instance.rds_instance.*.port,list("")),0)}"
}
