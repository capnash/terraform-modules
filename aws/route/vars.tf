variable "caller" {}

variable "envname" {
    default = []
}

variable "rtable" {}

variable "destination" {}

variable "out_gateway" {
    default = null
}

variable "gateway" {
    default = null
}

variable "instance" {
    default = null
}

variable "nat" {
    default = null
}

variable "nic" {
    default = null
}

variable "transit_gw" {
    default = null
}

variable "vpc_peer" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
