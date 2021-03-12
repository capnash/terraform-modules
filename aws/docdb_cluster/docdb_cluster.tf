resource "aws_docdb_cluster" "docdb_cluster" {
    apply_immediately = "${var.quick_changes}"
    availability_zones = "${var.a_zs}"
    backup_retention_period = "${var.retention_period}"
    cluster_identifier = "${lower(var.caller)}-${lower(var.name)}"
    db_subnet_group_name = "${var.subnet_group}"
    db_cluster_parameter_group_name = "${var.parameter_group}"
    enabled_cloudwatch_logs_exports = "${var.cloudwatch_exports}"
    engine_version = "${var.engine_version}"
    engine = "${var.engine}"
    final_snapshot_identifier = "${var.final_snapshot_id}"
    kms_key_id = "${var.kms}"
    master_password = "${var.password}"
    master_username = "${var.username}"
    port = "${var.port}"
    preferred_backup_window = "${var.backup_window}"
    skip_final_snapshot = "${var.skip_final_snapshot}"
    snapshot_identifier = "${var.snapshot_id}"
    storage_encrypted = "${var.encrypt}"
    vpc_security_group_ids = "${var.sec_groups}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
