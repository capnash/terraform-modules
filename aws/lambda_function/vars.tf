variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "iam_role" {}

variable "runtime" {}

variable "file" {
    default = null
}

variable "bucket" {
    default = null
}

variable "path" {
    default = null
}

variable "object_version" {
    default = null
}

variable "dead_letter" {
    default = []
}

variable "handle" {}

variable "layers" {
    default = []
}

variable "mem_limit" {
    default = 128
}

variable "timeout" {
    default = 10
}

variable "threads" {
    default = -1
}

variable "publish" {
    default = "false"
}

variable "kms_key" {
    default = ""
}

variable "hash" {
    default = ""
}

variable "vpc_config" {
    default = []
}

variable "subnets" {
    default = []
}

variable "secgroups" {
    default = []
}

variable "env_vars" {
    default = []
}

variable "error_target" {
    default = ""
}

locals {
    defaults = {
        vpc_config = {
            subnet_ids = []
            security_group_ids = []
        }
        dead_letter_config = {
            target_arn = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
