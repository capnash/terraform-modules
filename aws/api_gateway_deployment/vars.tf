variable "caller" {}

variable "envname" {
    default = []
}

variable "description" {}

variable "rest_api" {}

variable "stage" {
    default = null
}

variable "stage_description" {
    default = null
}

variable "triggers" {
    default = null
}

variable "env_vars" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
