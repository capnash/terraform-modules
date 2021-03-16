variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "destination" {}

variable "filter_pattern" {
    default = ""
}

variable "log_group" {}

variable "role" {
    default = null
}

variable "distribution" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
