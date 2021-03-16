resource "aws_docdb_cluster_instance" "docdb_instance" {
    apply_immediately = "${var.quick_changes}"
    auto_minor_version_upgrade = "${var.minor_upgrade}"
    availability_zone = "${var.a_z}"
    cluster_identifier = "${var.cluster_id}"
    engine = "${var.engine}"
    identifier = "${lower(var.caller)}-${lower(var.name)}-${count.index}"
    instance_class = "${var.size}"
    preferred_maintenance_window = "${var.maintenance_window}"
    promotion_tier = "${var.tier}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
