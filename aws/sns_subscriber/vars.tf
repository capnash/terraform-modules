variable "caller" {}

variable "envname" {
    default = []
}

variable "inparn" {}

variable "protocol" {
    default = "sqs"
}

variable "endpoint" {}

variable "confirm" {
    default = false
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
