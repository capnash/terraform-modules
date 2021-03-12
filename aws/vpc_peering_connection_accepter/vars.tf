variable "caller" {}

variable "envname" {
    default = []
}

variable "vpc_peering_conn" {}

variable "auto_accept" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
