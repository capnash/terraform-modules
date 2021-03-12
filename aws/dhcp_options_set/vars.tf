variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "dns_name" {}

variable "dns_servers" {
    default = ["8.8.8.8"]
}

variable "ntp_servers" {
    default = ["time.nist.gov"]
}

variable "netns" {
    default = []
}

variable "net_type" {
    default = 2
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
