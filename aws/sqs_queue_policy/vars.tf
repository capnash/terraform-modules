variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {
    default = "${var.envname} Terraform EC2 Instance"
}

variable "queue" {}

variable "q_policy" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
