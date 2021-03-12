variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "cidr" {}

variable "tenancy" {
    default = "default"
}

variable "dns_support" {
    default = "true"
}

variable "dns_names" {
    default = "false"
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
