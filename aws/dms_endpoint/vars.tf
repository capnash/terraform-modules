variable "database_name" {}
variable "endpoint_id" {}
variable "endpoint_type" {}
variable "engine_name" {}
variable "kms_key_arn" {}
variable "password" {}
variable "port" {}
variable "server_name" {}
variable "ssl_mode" {}
variable "username" {}
variable "caller" {}
variable "svc" {}
variable "envname" {
    default = []
}
variable "description" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
