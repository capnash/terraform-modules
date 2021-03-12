variable "caller" {}

variable "envname" {
    default = []
}

variable "listener" {}

variable "certificate" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
