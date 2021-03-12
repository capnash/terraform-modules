variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "shards" {}

variable "retention" {
    default = null
}

variable "metrics" {
    default = null
}

variable "require_deregistration" {
    default = null
}

variable "encryption" {
    default = null
}

variable "kms" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
