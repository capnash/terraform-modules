variable "replication_instance_arn" {}
variable "task_id" {}
variable "source_endpoint_arn" {}
variable "table_mappings" {}
variable "target_endpoint_arn" {}
variable "caller" {}
variable "svc" {}
variable "envname" {
    default = []
}
variable "description" {}
variable "replication_task_settings" {}

locals {
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
