resource "aws_rds_cluster_instance" "rds_instance" {
    identifier = "${lower(var.caller)}-${lower(var.name)}"
    identifier_prefix = "${var.prefix}"
    cluster_identifier = "${var.cluster}"
    engine = "${var.engine}"
    engine_version = "${var.engine_version}"
    instance_class = "${var.size}"
    publicly_accessible = "${var.public}"
    db_subnet_group_name = "${var.subnet_group}"
    db_parameter_group_name = "${var.parameter_group}"
    apply_immediately = "${var.apply_immediately}"
    monitoring_role_arn = "${var.log_arn}"
    monitoring_interval = "${var.monitor_interval}"
    promotion_tier = "${var.tier}"
    availability_zone = "${var.az}"
    preferred_backup_window = "${var.backup_window}"
    preferred_maintenance_window = "${var.maintenance_window}"
    auto_minor_version_upgrade = "${var.auto_minor_upgrade}"
    performance_insights_enabled = "${var.insights}"
    performance_insights_kms_key_id = "${var.insights_kms}"
    copy_tags_to_snapshot = true
    ca_cert_identifier = "${var.ca}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
