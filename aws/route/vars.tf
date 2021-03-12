variable "caller" {}

variable "envname" {
    default = []
}

variable "rtable" {}

variable "destination" {}

variable "out_gateway" {
    default = ""
}

variable "gateway" {
    default = ""
}

variable "instance" {
    default = ""
}

variable "nat" {
    default = ""
}

variable "nic" {
    default = ""
}

variable "transit_gw" {
    default = ""
}

variable "vpc_peer" {
    default = ""
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
