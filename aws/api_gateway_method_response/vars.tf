variable "caller" {}

variable "envname" {
    default = []
}

variable "rest_api" {}

variable "resource_id" {}

variable "http_method" {}

variable "status_code" {}

variable "response_models" {
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