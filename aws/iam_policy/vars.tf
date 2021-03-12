variable "caller" {}

variable "envname" {
    default = []
}

variable "scale" {
    default = 1
}

variable "name" {
    default = "Terraform-Role-Policy"
}

variable "description" {
    default = "Terraform initialized role policy"
}

variable "policy" {}

variable "path" {
    default = "/"
}

locals {
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${var.scale * local.enabled}"
}
