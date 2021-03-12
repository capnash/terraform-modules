variable "caller" {}

variable "envname" {
    default = []
}

variable "description" {}

variable "type" {}

variable "cidrs" {
    default = null
}

variable "allow_sec_group" {
    default = null
}

variable "from_port" {}

variable "to_port" {}

variable "protocol" {
    default = "tcp"
}

variable "sec_group" {}

variable "self_allow" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
