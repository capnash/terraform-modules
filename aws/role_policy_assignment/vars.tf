variable "caller" {}

variable "envname" {
    default = []
}

variable "policy" {}

variable "role" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
