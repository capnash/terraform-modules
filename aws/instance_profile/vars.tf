variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "role" {}

variable "path" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
