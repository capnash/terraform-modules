variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Generated By Terraform"
}

variable "group_id" {
    default = null
}

variable "engine" {
    default = null
}

variable "engine_version" {
    default = null
}

variable "maintenance_window" {
    default = null
}

variable "node_type" {
    default = null
}

variable "nodes" {
    default = null
}

variable "param_group" {
    default = null
}

variable "port" {
    default = null
}

variable "subnet_group" {
    default = null
}

variable "sec_groups" {
    default = null
}

variable "quick_apply" {
    default = null
}

variable "sns_topic" {
    default = null
}

variable "az_mode" {
    default = null
}

variable "a_z" {
    default = null
}

variable "a_zs" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
