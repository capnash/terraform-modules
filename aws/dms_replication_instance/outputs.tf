output "replication_instance_arn" {
    value = "${element(concat(aws_dms_replication_instance.replication_instance.*.replication_instance_arn,list("")),0)}"
}
