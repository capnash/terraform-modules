variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "vpc" {
    default = ""
}

variable "cidr" {
    default = ""
}

variable "a_z" {
    default = "us-east-1a"
}

variable "default_public" {
    default = "false"
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
