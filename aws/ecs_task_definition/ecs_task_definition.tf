resource "aws_ecs_task_definition" "ecs_task_definition" {
    family = "${var.caller}-${var.name}"
    container_definitions = "${var.definition}"
    task_role_arn = "${var.task_role}"
    execution_role_arn = "${var.daemon_role}"
    ipc_mode = "${var.ipc}"
    network_mode = "${var.network}"
    pid_mode = "${var.pid}"
    dynamic "volume" {
        for_each = [for key in var.volumes: {
            map = merge(local.defaults.volume,key)
        }]
        content {
            name = volume.value.map.name
            host_path = volume.value.map.host_path
            dynamic "docker_volume_configuration" {
                for_each = [for i in volume.value.map.docker_volume_configuration: {
                    map2 = merge(local.defaults.docker_volume_configuration,i)
                }]
                content {
                    scope = docker_volume_configuration.value.map2.scope
                    autoprovision = docker_volume_configuration.value.map2.autoprovision
                    driver = docker_volume_configuration.value.map2.driver
                    driver_opts = docker_volume_configuration.value.map2.driver_opts
                    labels = docker_volume_configuration.value.map2.labels
                }
            }
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
    cpu = "${var.cpu}"
    memory = "${var.memory}"
    requires_compatibilities = "${var.compatibilities}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
