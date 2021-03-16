variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created from Terraform"
}

variable "access_policies" {
    default = null
}

variable "options" {
    default = null
}

variable "ebs_options" {
    default = []
}

variable "vpc_options" {
    default = []
}

variable "encrypt_at_rest" {
    default = []
}

variable "node_to_node_encryption" {
    default = []
}

variable "cluster_config" {
    default = []
}

variable "snapshot_options" {
    default = []
}

variable "log_publishing_options" {
    default = []
}

variable "domain_version" {
    default = null
}

locals {
    defaults = {
        ebs_options = {
            ebs_enabled = true
            volume_type = null
            volume_size = 64
            iops = null
        }
        encrypt_at_rest = {
            enabled = true
            kms_key_id = "aws/es"
        }
        node_to_node_encryption = {
            enabled = true
        }
        cluster_config = {
            instance_type = null
            instance_count = null
            dedicated_master_enabled = null
            dedicated_master_type = null
            dedicated_master_count = null
            zone_awareness_config = []
            zone_awareness_enabled = null
        }
        zone_awareness_config = {
            availability_zone_count = 2
        }
        snapshot_options = {
            automated_snapshot_start_hour = 3
        }
        vpc_options = {
            security_group_ids = []
            subnet_ids = []
        }
        log_publishing_options = {
            log_type = "ES_APPLICATION_LOGS"
            cloudwatch_log_group_arn = ""
            enabled = true
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
