variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "engine_type" {
    default = "ActiveMQ"
}

variable "engine_version" {
    default = "5.15.0"
}

variable "engine_instance_type" {
    default = "mq.t2.micro"
}

variable "security_groups" {}

variable "subnet_ids" {}

variable "configuration_id" {}

variable "configuration_revision" {}

variable "username" {
    default = "TodayTix"
}

variable "password" {
    default = "strongpassword"
}

variable "console" {
    default = true
}

variable "groups" {
    default = null
}


locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
