variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "vpc" {}

variable "peer_owner" {
    default = null
}

variable "peer_vpc" {}

variable "auto_accept" {
    default = null
}

variable "peer_region" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
