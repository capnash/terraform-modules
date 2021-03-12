variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "action" {}

variable "source_token" {
    default = null
}

variable "function" {}

variable "trust" {}

variable "qualifier" {
    default = null
}

variable "account" {
    default = null
}

variable "source_arn" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
