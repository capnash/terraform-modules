variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {}

variable "apply_immediately" {
    default = null
}

variable "az" {
    default = null
}

variable "backtrack" {
    default = null
}

variable "retention" {
    default = null
}

variable "db_name" {
    default = null
}

variable "parameter_group" {
    default = null
}

variable "subnet_group" {
    default = []
}

variable "protected" {
    default = null
}

variable "enable_http" {
    default = null
}

variable "log_types" {
    default = null
}

variable "engine_mode" {
    default = null
}

variable "engine_version" {
    default = null
}

variable "engine" {
    default = "aurora"
}

variable "final_snapshot_identifier" {
    default = null
}

variable "global_cluster" {
    default = null
}

variable "iam_auth" {
    default = null
}

variable "iam_roles" {
    default = null
}

variable "kms" {
    default = null
}

variable "username" {}

variable "password" {}

variable "port" {
    default = null
}

variable "backup_window" {
    default = null
}

variable "maintenance_window" {
    default = null
}

variable "replication_source" {
    default = null
}

variable "skip_final_snapshot" {
    default = true
}

variable "snapshot" {
    default = null
}

variable "source_region" {
    default = null
}

variable "encrypted" {
    default = false
}

variable "sec_groups" {
    default = []
}

variable "s3_import" {
    default = []
}

variable "scaling_config" {
    default = []
}

locals {
    defaults = {
        s3_import = {
            bucket_name = ""
            bucket_prefix = null
            ingestion_role = ""
            source_engine = ""
            source_engine_version = ""
        }
        scaling_configuration = {
            auto_pause = null
            max_capacity = null
            min_capacity = null
            seconds_until_auto_pause = null
            timeout_action = null
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
