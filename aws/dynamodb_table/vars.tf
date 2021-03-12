variable "name" {

}

variable "billing_mode" {

}

variable "read_capacity" {
  default = 0
}

variable "write_capacity" {
  default = 0
}

variable "hash_key" {

}

variable "range_key" {

}

variable "caller" {

}

variable "envname" {
    default = []
}

variable "description" {

}

variable "svc" {

}

variable "ttl" {
    default = []
}

variable "attributes" {
  default = []
  type = list(object({ name = string, type = string }))
}

locals {
    defaults = {
        ttl = {
            attribute_name = "expirationTime"
            enabled        = true
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}