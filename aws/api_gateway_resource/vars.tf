variable "caller" {}

variable "envname" {
    default = []
}

variable "rest_api" {}

variable "parent_id" {}

variable "path" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
