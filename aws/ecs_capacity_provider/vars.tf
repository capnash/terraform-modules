variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "autoscaling_group" {}

variable "managed_scaling" {
    default = []
}

variable "protection" {
    default = null
}

locals {
    defaults = {
        managed_scaling = {
            maximum_scaling_step_size = null
            minimum_scaling_step_size = null
            status = null
            target_capacity = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}