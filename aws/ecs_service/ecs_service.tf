resource "aws_ecs_service" "ecs_service" {
    name = "${upper(var.caller)}-${var.name}"
    dynamic "capacity_provider_strategy" {
        for_each = [for key in var.capacity_provider_strategy: {
            map = merge(local.defaults.capacity_provider_strategy,key)
        }]
        content {
            capacity_provider = capacity_provider_strategy.value.map.capacity_provider
            weight = capacity_provider_strategy.value.map.weight
            base = capacity_provider_strategy.value.map.base
        }
    }
    task_definition = "${var.definition}"
    desired_count = "${var.nodes}"
    launch_type = "${var.type}"
    platform_version = "${var.platform_version}"
    scheduling_strategy = "${var.schedule}"
    cluster = "${var.cluster}"
    iam_role = "${var.role}"
    dynamic "deployment_controller" {
        for_each = [for key in var.deployment_controller: {
            map = merge(local.defaults.deployment_controller,key)
        }]
        content {
            type = deployment_controller.value.map.type
        }
    }
    deployment_maximum_percent = "${var.deploy_max_percent}"
    deployment_minimum_healthy_percent = "${var.deploy_min_health_percent}"
    dynamic "ordered_placement_strategy" {
        for_each = [for key in var.ordered_placement_strategy: {
            map = merge(local.defaults.ordered_placement_strategy,key)
        }]
        content {
            type = ordered_placement_strategy.value.map.type
            field = ordered_placement_strategy.value.map.field
        }
    }
    health_check_grace_period_seconds = "${var.health_check_grace_period}"
    dynamic "load_balancer" {
        for_each = [for key in var.load_balancer: {
            map = merge(local.defaults.load_balancer,key)
        }]
        content {
            elb_name = load_balancer.value.map.elb_name
            target_group_arn = load_balancer.value.map.target_group_arn
            container_name = load_balancer.value.map.container_name
            container_port = load_balancer.value.map.container_port
        }
    }
    dynamic "placement_constraints" {
        for_each = [for key in var.placement_constraints: {
            map = merge(local.defaults.placement_constraints,key)
        }]
        content {
            type = placement_constraints.value.map.type
            expression = placement_constraints.value.map.expression
        }
    }
    dynamic "network_configuration" {
        for_each = [for key in var.network_configuration: {
            map = merge(local.defaults.network_configuration,key)
        }]
        content {
            subnets = network_configuration.value.map.subnets
            security_groups = network_configuration.value.map.security_groups
            assign_public_ip = network_configuration.value.map.assign_public_ip
        }
    }
    dynamic "service_registries" {
        for_each = [for key in var.service_registries: {
            map = merge(local.defaults.service_registries,key)
        }]
        content {
            registry_arn = service_registries.value.map.service_registries
            port = service_registries.value.map.port
            container_port = service_registries.value.map.container_port
            container_name = service_registries.value.map.container_name
        }
    }

    count = "${local.farm}"
}
