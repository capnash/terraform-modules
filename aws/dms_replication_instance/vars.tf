variable "storage" {}
variable "availability_zone" {}
variable "kms_key" {}
variable "instance_class" {}
variable "replication_instance_id" {}
variable "subnet_group_id" {}
variable "vpc_sec_group_ids" {}
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
