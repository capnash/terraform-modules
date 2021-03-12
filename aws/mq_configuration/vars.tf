variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}
variable "engine_type" {
    default = "ActiveMQ"
}

variable "engine_version" {
    default = "5.15.0"
}

variable "engine_instance_type" {
    default = "mq.t2.micro"
}

variable "data" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}