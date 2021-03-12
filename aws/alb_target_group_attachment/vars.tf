variable "caller" {}

variable "envname" {
    default = []
}

variable "alb_target" {}

variable "endpoint" {}

variable "port" {
    default = null
}

variable "a_z" {
    default = ""
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
