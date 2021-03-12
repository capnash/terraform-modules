variable "caller" {}

variable "envname" {
    default = []
}

variable "rest_api" {}

variable "resource_id" {}

variable "http_method" {}

variable "authorization" {
    default = "NONE"
}

variable "authorizer" {
    default = null
}

variable "authorization_scopes" {
    default = null
}

variable "api_key_required" {
    default = null
}

variable "request_models" {
    default = null
}

variable "request_validator_id" {
    default = null
}

variable "request_parameters" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
