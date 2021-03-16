variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "path" {
    default = null
}

variable "permissions_boundary" {
    default = null
}

variable "force_destroy" {
    default = true
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
