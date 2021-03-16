resource "aws_autoscaling_group" "autoscaling_group" {
    name = "${var.caller}-${var.name}"
    max_size = var.max
    min_size = var.min
    capacity_rebalance = var.rebalance
    default_cooldown = var.cooldown
    health_check_grace_period = var.health_check_grace_period
    health_check_type = var.health_check_type
    force_delete = var.force_delete
    target_group_arns = var.target_groups
    vpc_zone_identifier = var.subnets
    termination_policies = var.termination_policies
    suspended_processes = var.suspended_processes
    placement_group = var.placement_group
    enabled_metrics = var.metrics
    wait_for_capacity_timeout = var.tf_timeout
    min_elb_capacity = var.min_capacity
    wait_for_elb_capacity = var.wait_for_capacity
    protect_from_scale_in = var.protection
    service_linked_role_arn = var.role
    max_instance_lifetime = var.max_lifetime
    launch_configuration = var.launch_config
    dynamic "launch_template" {
        for_each = [for key in var.launch_template:{
            map = merge(local.defaults.launch_template,key)
        }]
        content {
            id = launch_template.value.map.id
            name = launch_template.value.map.name
            version = launch_template.value.map.version
        }
    }
    dynamic "mixed_instances_policy" {
        for_each = [for key in var.mixed_instances_policy:{
            map = merge(local.defaults.mixed_instances_policy,key)
        }]
        content {
            dynamic "instances_distribution" {
                for_each = [for dist in mixed_instances_policy.value.map.instances_distribution:{
                    inst = merge(local.defaults.instances_distribution,dist)
                }]
                content {
                    on_demand_allocation_strategy = instances_distribution.value.inst.on_demand_allocation_strategy
                    on_demand_base_capacity = instances_distribution.value.inst.on_demand_base_capacity
                    on_demand_percentage_above_base_capacity = instances_distribution.value.inst.on_demand_percentage_above_base_capacity
                    spot_allocation_strategy = instances_distribution.value.inst.spot_allocation_strategy
                    spot_instance_pools = instances_distribution.value.inst.spot_instance_pools
                    spot_max_price = instances_distribution.value.inst.spot_max_price
                }
            }
            dynamic "launch_template" {
                for_each = [for tmp in mixed_instances_policy.value.map.launch_template:{
                    lnch = merge(local.defaults.mixed_launch_template,tmp)
                }]
                content {
                    dynamic "launch_template_specification" {
                        for_each = [for tmspc in launch_template.value.lnch.launch_template_specification:{
                            spec = merge(local.defaults.mixed_launch_policy,tmspc)
                        }]
                        content {
                            launch_template_id = launch_template_specification.value.spec.launch_template_id
                            launch_template_name = launch_template_specification.value.spec.launch_template_name
                            version = launch_template_specification.value.spec.version
                        }
                    }
                    dynamic "override" {
                        for_each = [for vr in launch_template.value.lnch.override:{
                            ovr = merge(local.defaults.override,vr)
                        }]
                        content {
                            instance_type = override.value.ovr.instance_type
                            weighted_capacity = override.value.ovr.weighted_capacity
                        }
                    }
                }
            }
        }
    }
    dynamic "initial_lifecycle_hook" {
        for_each = [for key in var.initial_lifecycle_hook:{
            map = merge(local.defaults.lifecycle_hook,key)
        }]
        content {
            name = "${var.caller}-${initial_lifecycle_hook.value.map.name}"
            default_result = initial_lifecycle_hook.value.map.default_result
            heartbeat_timeout = initial_lifecycle_hook.value.map.timeout
            lifecycle_transition = initial_lifecycle_hook.value.map.lifecycle_transition
            notification_metadata = initial_lifecycle_hook.value.map.notification_metadata
            notification_target_arn = initial_lifecycle_hook.value.map.notification_target
            role_arn = initial_lifecycle_hook.value.map.role
        }
    }
    dynamic "instance_refresh" {
        for_each = [for key in var.instance_refresh:{
            map = merge(local.defaults.instance_refresh,key)
        }]
        content {
            strategy = instance_refresh.value.map.strategy
            dynamic "preferences" {
                for_each = [for pr in instance_refresh.value.map.preferences:{
                    pref = merge(local.defaults.preferences,pr)
                }]
                content {
                    instance_warmup = preferences.value.pref.instance_warmup
                    min_healthy_percentage = preferences.value.pref.min_healthy_percentage
                }
            }
            triggers = instance_refresh.value.map.triggers
        }
    }
    tags = var.tags

    count = local.farm
}
