variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "capacity_provider_strategy" {
    default = []
}

variable "definition" {}

variable "nodes" {
    default = 0
}

variable "type" {
    default = "FARGATE"
}

variable "platform_version" {
    default = ""
}

variable "schedule" {
    default = "REPLICA"
}

variable "cluster" {
    default = ""
}

variable "role" {
    default = null
}

variable "deployment_controller" {
    default = []
}

variable "deploy_max_percent" {
    default = null
}

variable "deploy_min_health_percent" {
    default = null
}

variable "ordered_placement_strategy" {
    default = []
}

variable "health_check_grace_period" {
    default = null
}

variable "load_balancer" {
    default = []
}

variable "placement_constraints" {
    default = []
}

variable "network_configuration" {
    default = []
}

variable "service_registries" {
    default = []
}

locals {
    defaults = {
        capacity_provider_strategy = {
            capacity_provider = ""
            weight = 25
            base = null
        }
        deployment_controller = {
            type = "ECS"
        }
        load_balancer = {
            elb_name = null
            target_group_arn = null
            container_name = "${var.name}"
            container_port = 80
        }
        ordered_placement_strategy = {
            type = "random"
            field = null
        }
        placement_constraints = {
            type = "memberOf"
            expression = null
        }
        network_configuration = {
            subnets = []
            security_groups = null
            assign_public_ip = false
        }
        service_registries = {
            registry_arn = ""
            port = null
            container_port = null
            container_name = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
