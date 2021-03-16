variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "family" {
    default = "aurora5.6"
}

variable "parameters" {
    default = []
}

locals {
    defaults = {
        parameter = {
            name = ""
            value = ""
            apply_method = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
