output "subnet_group_id" {
    value = "${element(concat(aws_dms_replication_subnet_group.dms_subnet_group.*.replication_subnet_group_id,list("")),0)}"
}