resource "aws_rds_cluster" "rds_cluster" {
    apply_immediately = "${var.apply_immediately}"
    availability_zones = "${var.az}"
    backtrack_window = "${var.backtrack}"
    backup_retention_period = "${var.retention}"
    cluster_identifier = "${lower(var.caller)}-${lower(var.name)}"
    copy_tags_to_snapshot = true
    database_name = "${var.db_name}"
    db_cluster_parameter_group_name = "${var.parameter_group}"
    db_subnet_group_name = "${var.subnet_group}"
    deletion_protection = "${var.protected}"
    enable_http_endpoint = "${var.enable_http}"
    enabled_cloudwatch_logs_exports = "${var.log_types}"
    engine_mode = "${var.engine_mode}"
    engine_version = "${var.engine_version}"
    engine = "${var.engine}"
    final_snapshot_identifier = "${var.final_snapshot_identifier}"
    global_cluster_identifier = "${var.global_cluster}"
    iam_database_authentication_enabled = "${var.iam_auth}"
    iam_roles = "${var.iam_roles}"
    kms_key_id = "${var.kms}"
    master_username = "${var.username}"
    master_password = "${var.password}"
    port = "${var.port}"
    preferred_backup_window = "${var.backup_window}"
    preferred_maintenance_window = "${var.maintenance_window}"
    replication_source_identifier = "${var.replication_source}"
    skip_final_snapshot = "${var.skip_final_snapshot}"
    snapshot_identifier = "${var.snapshot}"
    source_region = "${var.source_region}"
    storage_encrypted = "${var.encrypted}"
    vpc_security_group_ids = "${var.sec_groups}"
    dynamic "s3_import" {
        for_each = [for key in var.s3_import: {
            map = merge(local.defaults.s3_import,key)
        }]
        content {
            bucket_name = s3_import.value.map.bucket_name
            bucket_prefix = s3_import.value.bucket_prefix
            ingestion_role = s3_import.value.ingestion_role
            source_engine = s3_import.value.source_engine
            source_engine_version = s3_import.value.source_engine_version
        }
    }
    dynamic "scaling_configuration" {
        for_each = [for key in var.scaling_config: {
            map = merge(local.defaults.scaling_configuration,key)
        }]
        content {
            auto_pause = scaling_configuration.value.map.auto_pause
            max_capacity = scaling_configuration.value.map.max_capacity
            min_capacity = scaling_configuration.value.map.min_capacity
            seconds_until_auto_pause = scaling_configuration.value.map.seconds_until_auto_pause
            timeout_action = scaling_configuration.value.map.timeout_action
        }
    }
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
