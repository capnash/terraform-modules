resource "aws_dms_replication_task" "dms_replication_task" {
    migration_type = "full-load-and-cdc"
    replication_instance_arn = var.replication_instance_arn
    replication_task_id = "${var.caller}-${var.task_id}"
    source_endpoint_arn = var.source_endpoint_arn
    table_mappings = var.table_mappings

    target_endpoint_arn = var.target_endpoint_arn
    replication_task_settings = var.replication_task_settings 

    tags = {
        Name = "${var.caller}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
        Description = var.description
    }

    count = local.farm
}