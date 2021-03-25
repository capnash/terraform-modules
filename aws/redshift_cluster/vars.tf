variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "db_name" {
    default = null
}

variable "node_type" {
    default = "ds2.large"
}

variable "cluster_type" {
    default = "multi-node"
}

variable "master_pass" {
    default = null
}

variable "master_user" {
    default = null
}

variable "sec_groups" {
    default = null
}

variable "subnet_group" {
    default = null
}

variable "az" {
    default = "us-east-1"
}

variable "maintenance_window" {
    default = null
}

variable "parameter_group" {
    default = null
}

variable "snapshot_retention" {
    default = 0
}

variable "port" {
    default = 5439
}

variable "cluster_version" {
    default = null
}

variable "allow_upgrade" {
    default = true
}

variable "nodes" {
    default = 1
}

variable "public" {
    default = false
}

variable "encrypt" {
    default = false
}

variable "enhanced_routing" {
    default = null
}

variable "kms" {
    default = null
}

variable "public_ip" {
    default = null
}

variable "skip_final_snapshot" {
    default = false
}

variable "final_snapshot_id" {
    default = null
}

variable "source_cluster" {
    default = null
}

variable "snapshot_owner_account" {
    default = null
}

variable "roles" {
    default = []
}

variable "logging" {
    default = []
}

variable "snapshot_copy" {
    default = []
}

locals {
    defaults = {
        logging = {
            enable = true
            bucket_name = ""
            s3_key_prefix = null
        }
        snapshot_copy = {
            destination_region = "us-east-1"
            retention_period = 7
            grant_name = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}