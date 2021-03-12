variable "caller" {}

variable "envname" {
    default = []
}

variable "vpc" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created from Terraform"
}

variable "force_destroy" {
    default = "true"
}

locals {
    defaults = {
        vpc = {
            vpc_id = ""
            vpc_region = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
