variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "internal" {
    default = "false"
}

variable "type" {
    default = "application"
}

variable "sec_groups" {
    default = []
}

variable "subnets" {
    default = []
}

variable "timeout" {
    default = 60
}

variable "protected" {
    default = "false"
}

variable "cross_zone" {
    default = "true"
}

variable "http2" {
    default = "true"
}

variable "ip_type" {
    default = "ipv4"
}

variable "logs" {
    default = []
}

variable "subnet_mapping" {
    default = []
}

locals {
    defaults = {
        access_logs = {
            bucket = ""
            enabled = true
        }
        subnet_mapping = {
            subnet_id = ""
            allocation_id = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
