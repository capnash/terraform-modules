resource "aws_elasticsearch_domain" "elasticsearch_domain" {
    domain_name = "${var.caller}-${var.name}"
    access_policies = "${var.access_policies}"
    advanced_options = "${var.options}"
    elasticsearch_version = "${var.domain_version}"
    dynamic "ebs_options" {
        for_each = [for key in var.ebs_options: {
            map = merge(local.defaults.ebs_options,key)
        }]
        content {
            ebs_enabled = ebs_options.value.map.ebs_enabled
            volume_type = ebs_options.value.map.volume_type
            volume_size = ebs_options.value.map.volume_size
            iops = ebs_options.value.map.iops
        }
    }
    dynamic "encrypt_at_rest" {
        for_each = [for key in var.encrypt_at_rest: {
            map = merge(local.defaults.encrypt_at_rest,key)
        }]
        content {
            enabled = encrypt_at_rest.value.map.enabled
            kms_key_id = encrypt_at_rest.value.map.kms_key_id
        }
    }
    dynamic "node_to_node_encryption" {
        for_each = [for key in var.node_to_node_encryption: {
            map = merge(local.defaults.node_to_node_encryption,key)
        }]
        content {
            enabled = node_to_node_encryption.value.map.enabled
        }
    }
    dynamic "cluster_config" {
        for_each = [for key in var.cluster_config: {
            map = merge(local.defaults.cluster_config,key)
        }]
        content {
            instance_type = cluster_config.value.map.instance_type
            instance_count = cluster_config.value.map.instance_count
            dedicated_master_enabled = cluster_config.value.map.dedicated_master_enabled
            dedicated_master_type = cluster_config.value.map.dedicated_master_type
            dedicated_master_count = cluster_config.value.map.dedicated_master_count
            zone_awareness_enabled = cluster_config.value.map.zone_awareness_enabled
            dynamic "zone_awareness_config" {
                for_each = [for i in cluster_config.value.map.zone_awareness_config: {
                    zone_map = merge(local.defaults.zone_awareness_config,i)
                }]
                content {
                    availability_zone_count = zone_awareness_config.value.zone_map.availability_zone_count
                }
            }
        }
    }
    dynamic "snapshot_options" {
        for_each = [for key in var.snapshot_options: {
            map = merge(local.defaults.snapshot_options,key)
        }]
        content {
            automated_snapshot_start_hour = snapshot_options.value.map.automated_snapshot_start_hour
        }
    }
    dynamic "vpc_options" {
        for_each = [for key in var.vpc_options: {
            map = merge(local.defaults.vpc_options,key)
        }]
        content {
            security_group_ids = vpc_options.value.map.security_group_ids
            subnet_ids = vpc_options.value.map.subnet_ids
        }
    }
    dynamic "log_publishing_options" {
        for_each = [for key in var.log_publishing_options: {
            map = merge(local.defaults.log_publishing_options,key)
        }]
        content {
            log_type = log_publishing_options.value.map.log_type
            cloudwatch_log_group_arn = log_publishing_options.value.map.cloudwatch_log_group_arn
            enabled = log_publishing_options.value.map.enabled
        }
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
