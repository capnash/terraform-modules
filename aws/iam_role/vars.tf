variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "policy" {
    default = ""
}

variable "purge_policies" {
    default = "false"
}

variable "iam_path" {
    default = "/"
}

variable "perm_bound" {
    default = ""
}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
