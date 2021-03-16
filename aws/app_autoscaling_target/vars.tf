variable "name" {}

variable "caller" {}

variable "envname" {
    default = []
}

variable "max" {}

variable "min" {}

variable "resource_id" {}

variable "role" {
    default = null
}

variable "dimension" {}

variable "namespace" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}