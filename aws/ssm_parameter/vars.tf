variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created from Terraform"
}

variable "type" {
    default = "SecureString"
}

variable "value" {}

variable "tier" {
    default = null
}

variable "kms" {}

variable "overwrite" {
    default = null
}

variable "pattern" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
