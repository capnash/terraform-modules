variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "autoscaling_group" {}

variable "default_result" {
    default = null
}

variable "timeout" {
    default = null
}

variable "lifecycle_transition" {}

variable "notification_metadata" {
    default = null
}

variable "notification_target" {
    default = null
}

variable "role" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}