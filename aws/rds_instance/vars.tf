variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "prefix" {
    default = null
}

variable "cluster" {
    default = null
}

variable "engine" {
    default = "aurora"
}

variable "engine_version" {
    default = null
}

variable "size" {
    default = "db.r5.large"
}

variable "public" {
    default = false
}

variable "subnet_group" {}

variable "parameter_group" {
    default = null
}

variable "apply_immediately" {
    default = false
}

variable "log_arn" {
    default = null
}

variable "monitor_interval" {
    default = null
}

variable "tier" {
    default = null
}

variable "az" {
    default = null
}

variable "backup_window" {
    default = null
}

variable "maintenance_window" {
    default = null
}

variable "auto_minor_upgrade" {
    default = true
}

variable "insights" {
    default = null
}

variable "insights_kms" {
    default = null
}

variable "ca" {
    default = null
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
