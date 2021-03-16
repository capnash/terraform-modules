variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "autoscaling_group" {}

variable "start" {
    default = null
}

variable "end" {
    default = null
}

variable "recurrence" {
    default = null
}

variable "min" {
    default = -1
}

variable "max" {
    default = -1
}

variable "capacity" {
    default = -1
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}