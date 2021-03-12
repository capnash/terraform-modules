variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "visible_timeout" {
    default = 30
}

variable "retention" {
    default = 345600
}

variable "message_size" {
    default = 262144
}

variable "delay" {
    default = 0
}

variable "wait_time" {
    default = 0
}

variable "policy" {
    default = ""
}

variable "redrive" {
    default = ""
}

variable "fifo" {
    default = "false"
}

variable "dedupe" {
    default = "false"
}

variable "master_key" {
    default = ""
}

variable "key_reuse_time" {
    default = 300
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
