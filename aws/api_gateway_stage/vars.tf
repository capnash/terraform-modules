variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "rest_api" {}

variable "deployment" {}

variable "log_settings" {
    default = null
}

variable "cache_enabled" {
    default = null
}

variable "cache_cluster_size" {
    default = null
}

variable "client_cert" {
    default = null
}

variable "doc_version" {
    default = null
}

variable "env_vars" {
    default = null
}

variable "xray_trace" {
    default = null
}

locals {
    defaults = {
        access_log_settings = {
            destination_arn = ""
            format = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
