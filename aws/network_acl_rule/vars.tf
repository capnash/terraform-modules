variable "caller" {}

variable "envname" {
    default = []
}

variable "acl" {}

variable "priority" {}

variable "outgoing" {
    default = "false"
}

variable "protocol" {}

variable "action" {}

variable "cidr" {}

variable "from" {}

variable "to" {}

variable "icmp_type" {
    default = -1
}

variable "icmp_code" {
    default = -1
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
