variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "acl" {
    default = "private"
}

variable "policy" {
    default = null
}

variable "kill_all" {
    default = "false"
}

variable "website" {
    default = []
}

variable "cors_rule" {
    default = []
}

variable "versioning" {
    default = []
}

variable "logging" {
    default = []
}

variable "lifecycle_rule" {
    default = []
}

variable "payer" {
    default = "BucketOwner"
}

variable "accelerate" {
    default = null
}

variable "replication_configuration" {
    default = []
}

variable "server_side_encryption" {
    default = []
}

variable "object_lock" {
    default = []
}

locals {
    defaults = {
        website = {
            index_document = null
            error_document = null
            redirect_all_requests_to = null
            routing_rules = null
        }
        cors_rule = {
            allowed_headers = null
            allowed_methods = ["HEAD","GET"]
            allowed_origins = []
            expose_headers = null
            max_age_seconds = null
        }
        versioning = {
            enabled = null
            mfa_delete = null
        }
        logging = {
            target_bucket = ""
            target_prefix = null
        }
        lifecycle_rule = {
            id = null
            enabled = true
            tags = null
            abort_incomplete_multipart_upload_days = null
        }
        lifecycle_expiration = {
            date = null
            days = null
            expired_object_delete_marker = null
        }
        lifecycle_transition = {
            date = null
            days = null
            storage_class = "STANDARD_IA"
        }
        lifecycle_noncurrent_version_expiration = {
            days = 365
        }
        lifecycle_noncurrent_version_transition = {
            days = 365
            storage_class = "STANDARD_IA"
        }
        replication_configuration = {
            role = ""
            rules = {
                id = null
                priority = null
                prefix = null
                status = "Enabled"
                destination = {
                    bucket = ""
                    storage_class = "STANDARD_IA"
                    replica_kms_key_id = null
                    access_control_translation = null
                    account_id = null
                }
            }
        }
        access_control_translation = {
            owner = "Destination"
        }
        source_selection_criteria = {
            see_kms_encrypted_objects = []
        }
        sse_kms_encrypted_objects = {
            enabled = true
        }
        replication_filter = {
            prefix = null
            tags = null
        }
        server_side_encryption_configuration = {
            rule = {
                apply_server_side_encryption_by_default = {
                    sse_algorithm = "aws:kms"
                }
            }
        }
        object_lock_configuration = {
            object_lock_enabled = true
        }
        object_lock_rule = {
            default_retention = {
                mode = "GOVERNANCE"
                days = null
                years = null
            }
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
