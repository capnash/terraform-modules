resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
    name = "${var.caller}-${var.name}"
    auto_scaling_group_provider {
        auto_scaling_group_arn = var.autoscaling_group
        dynamic "managed_scaling" {
            for_each = [for key in var.managed_scaling:{
                map = merge(local.defaults.managed_scaling,key)
            }]
            content {
                maximum_scaling_step_size = managed_scaling.value.map.maximum_scaling_step_size
                minimum_scaling_step_size = managed_scaling.value.map.minimum_scaling_step_size
                status = managed_scaling.value.map.status
                target_capacity = managed_scaling.value.map.target_capacity
            }
        }
        managed_termination_protection = var.protection
    }
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = var.description
        Environment = var.caller
        Service = var.svc
    }
}