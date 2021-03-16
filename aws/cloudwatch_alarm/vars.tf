variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "metric" {}

variable "operator" {
    default = "LessThanOrEqualToThreshold"
}

variable "threshold" {
    default = 0
}

variable "datapoints" {
    default = 0
}

variable "eval_pds" {
    default = 1
}

variable "stats" {
    default = "Average"
}

variable "period" {
    default = 60
}

variable "namespace" {}

variable "dimensions" {
    default = {}
}

variable "missdata" {
    default = "missing"
}

variable "eval_pcts" {
    default = "ignore"
}

variable "alarmx" {
    default = []
}

variable "badatx" {
    default = []
}

variable "okx" {
    default = []
}

variable "enablex" {
    default = "true"
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
