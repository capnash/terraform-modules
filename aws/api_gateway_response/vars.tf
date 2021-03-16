variable "caller" {}

variable "envname" {
    default = []
}

variable "rest_api" {}

variable "type" {}

variable "status_code" {}

variable "response_templates" {
    default = null
}

variable "response_parameters" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}