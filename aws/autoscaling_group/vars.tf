variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "max" {}

variable "min" {}

variable "rebalance" {
    default = null
}

variable "cooldown" {
    default = null
}

variable "health_check_grace_period" {
    default = 300
}

variable "health_check_type" {
    default = "ELB"
}

variable "force_delete" {
    default = false
}

variable "target_groups" {
    default = null
}

variable "subnets" {
    default = null
}

variable "termination_policies" {
    default = null
}

variable "suspended_processes" {
    default = null
}

variable "placement_group" {
    default = null
}

variable "metrics" {
    default = ["1Minute"]
}

variable "tf_timeout" {
    default = "10m"
}

variable "min_capacity" {
    default = null
}

variable "wait_for_capacity" {
    default = null
}

variable "protection" {
    default = null
}

variable "role" {
    default = null
}

variable "max_lifetime" {
    default = null
}

variable "launch_config" {
    default = null
}

variable "tags" {
    default = null
}

variable "launch_template" {
    default = []
}

variable "mixed_instances_policy" {
    default = []
}

variable "initial_lifecycle_hook" {
    default = []
}

variable "instance_refresh" {
    default = []
}

locals {
    defaults = {
        launch_template = {
            id = null
            name = null
            version = "$Default"
        }
        mixed_instances_policy = {
            instances_distribution = []
            launch_template = []
        }
        instances_distribution = {
            on_demand_allocation_strategy = "prioritized"
            on_demand_base_capacity = 0
            on_demand_percentage_above_base_capacity = 0
            spot_allocation_strategy = "lowest-price"
            spot_instance_pools = 2
            spot_max_price = ""
        }
        mixed_launch_template = {
            launch_template_specification = []
            override = []
        }
        mixed_launch_policy = {
            launch_template_id = null
            launch_template_name = null
            version = null
        }
        override = {
            instance_type = null
            weighted_capacity = null
        }
        lifecycle_hook = {
            name = "${var.name}-Lifecycle Hook"
            default_result = "ABANDON"
            timeout = null
            lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
            notification_metadata = null
            notification_target = null
            role = null
        }
        instance_refresh = {
            strategy = "Rolling"
            preferences = []
            triggers = null
        }
        preferences = {
            instance_warmup = null
            min_healthy_percentage = 90
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
