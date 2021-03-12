variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "parameters" {
    default = []
}

locals {
    defaults = {
        parameter = {
            name = ""
            value = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
