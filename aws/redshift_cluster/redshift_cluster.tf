resource "aws_redshift_cluster" "redshift_cluster" {
    cluster_identifier = "${lower(var.caller)}-${lower(var.name)}"
    database_name = var.db_name
    node_type = var.node_type
    cluster_type = var.cluster_type
    master_password = var.master_pass
    master_username = var.master_user
    vpc_security_group_ids = var.sec_groups
    cluster_subnet_group_name = var.subnet_group
    availability_zone = var.az
    preferred_maintenance_window = var.maintenance_window
    cluster_parameter_group_name = var.parameter_group
    automated_snapshot_retention_period = var.snapshot_retention
    port = var.port
    cluster_version = var.cluster_version
    allow_version_upgrade = var.allow_upgrade
    number_of_nodes = var.nodes
    publicly_accessible = var.public
    encrypted = var.encrypt
    enhanced_vpc_routing = var.enhanced_routing
    kms_key_id = var.kms
    elastic_ip = var.public_ip
    skip_final_snapshot = var.skip_final_snapshot
    final_snapshot_identifier = var.final_snapshot_id
    snapshot_cluster_identifier = var.source_cluster
    owner_account = var.snapshot_owner_account
    iam_roles = var.roles
    dynamic "logging" {
        for_each = [for key in var.logging:{
            map = merge(local.defaults.logging,key)
        }]
        content{
            enable = logging.value.map.enable
            bucket_name = logging.value.map.bucket_name
            s3_key_prefix = logging.value.map.s3_key_prefix
        }
    }
    dynamic "snapshot_copy" {
        for_each = [for key in var.snapshot_copy:{
            map = merge(local.defaults.snapshot_copy,key)
        }]
        content {
            destination_region = snapshot_copy.value.map.destination_region
            retention_period = snapshot_copy.value.map.retention_period
            grant_name = snapshot_copy.value.map.grant_name
        }
    }
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = var.description
        Environment = var.caller
        Service = var.svc
    }

    count = local.farm
}