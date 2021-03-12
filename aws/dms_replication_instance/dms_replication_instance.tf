resource "aws_dms_replication_instance" "replication_instance" {
    allocated_storage = var.storage
    apply_immediately = true
    auto_minor_version_upgrade = true
    availability_zone = var.availability_zone
    engine_version = "3.1.4"
    kms_key_arn = var.kms_key
    multi_az = false
    preferred_maintenance_window = "sun:07:40-sun:08:20"
    publicly_accessible = false
    replication_instance_class = var.instance_class
    replication_instance_id = var.replication_instance_id
    replication_subnet_group_id = var.subnet_group_id

    vpc_security_group_ids = var.vpc_sec_group_ids

    tags = {
        Name = "${upper(var.caller)}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
        Description = var.description
    }

    count = local.farm
}