variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "definition" {}

variable "task_role" {
    default = null
}

variable "daemon_role" {
    default = null
}

variable "network" {
    default = null
}

variable "ipc" {
    default = null
}

variable "pid" {
    default = null
}

variable "volumes" {
    default = []
}

variable "placement_constraints" {
    default = []
}

variable "cpu" {
    default = null
}

variable "memory" {
    default = null
}

variable "compatibilities" {
    default = null
}

locals {
    defaults = {
        volume = {
            name = ""
            host_path = null
            docker_volume_configuration = []
        }
        docker_volume_configuration = {
            scope = null
            autoprovision = null
            driver = null
            driver_opts = null
            labels = {}
        }
        placement_constraints = {
            type = "memberOf"
            expression = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
