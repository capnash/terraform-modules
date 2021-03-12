variable "caller" {}

variable "envname" {
    default = []
}

variable "eip" {}

variable "instance" {
    default = ""
}

variable "interface" {
    default = ""
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
