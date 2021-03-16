variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Generated from Terraform"
}

variable "kms" {
    default = null
}

variable "policy" {
    default = null
}

variable "recovery_days" {
    default = 30
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
