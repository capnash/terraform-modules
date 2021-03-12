variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "endpoint_config" {
    default = []
}

variable "binary_media_types" {
    default = null
}

variable "compression_size" {
    default = null
}

variable "policy" {
    default = null
}

variable "api_key_source" {
    default = null
}

locals {
    defaults = {
        endpoint_configuration = {
            types = []
            vpc_endpoint_ids = []
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
