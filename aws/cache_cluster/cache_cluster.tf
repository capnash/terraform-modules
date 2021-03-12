resource "aws_elasticache_cluster" "cache_cluster" {
    cluster_id = "${lower(var.caller)}-${lower(var.name)}"
    replication_group_id = "${var.group_id}"
    engine = "${var.engine}"
    engine_version = "${var.engine_version}"
    maintenance_window = "${var.maintenance_window}"
    node_type = "${var.node_type}"
    num_cache_nodes = "${var.nodes}"
    parameter_group_name = "${var.param_group}"
    port = "${var.port}"
    subnet_group_name = "${var.subnet_group}"
    security_group_ids = "${var.sec_groups}"
    apply_immediately = "${var.quick_apply}"
    notification_topic_arn = "${var.sns_topic}"
    az_mode = "${var.az_mode}"
    availability_zone = "${var.a_z}"
    preferred_availability_zones = "${var.a_zs}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
