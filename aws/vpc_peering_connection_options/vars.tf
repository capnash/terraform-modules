variable "caller" {}

variable "envname" {
    default = []
}

variable "vpc_peering_conn" {}

variable "accepter" {
    default = []
}

variable "requester" {
    default = []
}

locals {
    defaults = {
        accepter = {
            allow_remote_vpc_dns_resolution = null
            allow_classic_link_to_remote_vpc = null
            allow_vpc_to_remote_classic_link = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
