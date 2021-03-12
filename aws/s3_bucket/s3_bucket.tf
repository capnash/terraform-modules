resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.caller}-${var.name}"
    acl = "${var.acl}"
    policy = "${var.policy}"
    force_destroy = "${var.kill_all}"
    request_payer = "${var.payer}"
    acceleration_status = "${var.accelerate}"
    dynamic "website" {
        for_each = [for key in var.website: {
            map = merge(local.defaults.website,key)
        }]
        content {
            index_document = website.value.map.index_document
            error_document = website.value.map.error_document
            redirect_all_requests_to = website.value.map.redirect_all_requests_to
            routing_rules = website.value.map.routing_rules
        }
    }
    dynamic "cors_rule" {
        for_each = [for key in var.cors_rule: {
            map = merge(local.defaults.cors_rule,key)
        }]
        content {
            allowed_headers = cors_rule.value.map.allowed_headers
            allowed_methods = cors_rule.value.map.allowed_methods
            allowed_origins = cors_rule.value.map.allowed_origins
            expose_headers = cors_rule.value.map.expose_headers
            max_age_seconds = cors_rule.value.map.max_age_seconds
        }
    }
    dynamic "versioning" {
        for_each = [for key in var.versioning: {
            map = merge(local.defaults.versioning,key)
        }]
        content {
            enabled = versioning.value.map.enabled
            mfa_delete = versioning.value.map.mfa_delete
        }
    }
    dynamic "logging" {
        for_each = [for key in var.logging: {
            map = merge(local.defaults.logging,key)
        }]
        content {
            target_bucket = logging.value.map.target_bucket
            target_prefix = logging.value.map.target_prefix
        }
    }
    dynamic "lifecycle_rule" {
        for_each = [for key in var.lifecycle_rule: {
            map = merge(local.defaults.lifecycle_rule,key)
        }]
        content {
            id = lifecycle_rule.value.map.id
            enabled = lifecycle_rule.value.map.enabled
            tags = lifecycle_rule.value.map.tags
            abort_incomplete_multipart_upload_days = lifecycle_rule.value.map.abort_incomplete_multipart_upload_days
            dynamic "expiration" {
                for_each = [for i in lifecycle_rule.value.map.expiration: {
                    exp = merge(local.defaults.lifecycle_expiration,i)
                }]
                content {
                    date = expiration.value.exp.date
                    days = expiration.value.exp.days
                    expired_object_delete_marker = expiration.value.exp.expired_object_delete_marker
                }
            }
            dynamic "transition" {
                for_each = [for n in lifecycle_rule.value.map.transition: {
                    tran = merge(local.defaults.lifecycle_transition,n)
                }]
                content {
                    date = expiration.value.tran.date
                    days = expiration.value.tran.days
                    storage_class = expiration.value.tran.storage_class
                }
            }
            dynamic "noncurrent_version_expiration" {
                for_each = [for x in lifecycle_rule.value.map.noncurrent_version_expiration: {
                    nonex = merge(local.defaults.lifecycle_noncurrent_version_expiration,x)
                }]
                content {
                    days = noncurrent_version_expiration.value.nonex.days
                }
            }
            dynamic "noncurrent_version_transition" {
                for_each = [for z in lifecycle_rule.value.map.noncurrent_version_transition: {
                    nontra = merge(local.defaults.lifecycle_noncurrent_version_transition,z)
                }]
                content {
                    days = noncurrent_version_transition.value.nontra.days
                    storage_class = noncurrent_version_transition.value.nontra.storage_class
                }
            }
        }
    }
    dynamic "replication_configuration" {
        for_each = [for key in var.replication_configuration: {
            map = merge(local.defaults.replication_configuration,key)
        }]
        content {
            role = replication_configuration.value.map.role
            rules {
                id = replication_configuration.value.map.rules.id
                priority = replication_configuration.value.map.rules.priority
                prefix = replication_configuration.value.map.rules.prefix
                status = replication_configuration.value.map.rules.status
                destination {
                    bucket = replication_configuration.value.map.rules.destination.bucket
                    storage_class = replication_configuration.value.map.rules.destination.storage_class
                    replica_kms_key_id = replication_configuration.value.map.rules.destination.replica_kms_key_id
                    account_id = replication_configuration.value.map.rules.destination.account_id
                    dynamic "access_control_translation" {
                        for_each = [for z in replication_configuration.value.map.rules.destination.access_control_translation: {
                            axsct = merge(local.defaults.access_control_translation,z)
                        }]
                        content {
                            owner = access_control_translation.value.axsct.owner
                        }
                    }
                }
                dynamic "source_selection_criteria" {
                    for_each = [for i in replication_configuration.value.map.rules.source_selection_criteria: {
                        crit = merge(local.defaults.source_selection_criteria,i)
                    }]
                    content {
                        dynamic "sse_kms_encrypted_objects" {
                            for_each = [for x in source_selection_criteria.value.crit.sse_kms_encrypted_objects: {
                                sse = merge(local.defaults.sse_kms_encrypted_objects,x)
                            }]
                            content {
                                enabled = sse_kms_encrypted_objects.value.sse.enabled
                            }
                        }
                    }
                }
                dynamic "filter" {
                    for_each = [for n in replication_configuration.value.map.rules.filter: {
                        filt = merge(local.defaults.replication_filter,n)
                    }]
                    content {
                        prefix = filter.value.filt.prefix
                        tags = filter.value.filt.tags
                    }
                }
            }
        }
    }
    dynamic "server_side_encryption_configuration" {
        for_each = [for key in var.server_side_encryption: {
            map = merge(local.defaults.server_side_encryption_configuration,key)
        }]
        content {
            rule {
                apply_server_side_encryption_by_default {
                    sse_algorithm = server_side_encryption_configuration.value.map.rule.apply_server_side_encryption_by_default.sse_algorithm
                }
            }
        }
    }
    dynamic "object_lock_configuration" {
        for_each = [for key in var.object_lock: {
            map = merge(local.defaults.object_lock_configuration,key)
        }]
        content {
            object_lock_enabled = object_lock_configuration.value.map.object_lock_enabled
            dynamic "rule" {
                for_each = [for i in object_lock_configuration.value.map.rule: {
                    nrule = merge(local.defaults.object_lock_rule)
                }]
                content {
                    default_retention {
                        mode = rule.value.nrule.default_retention.mode
                        days = rule.value.nrule.default_retention.days
                        years = rule.value.nrule.default_retention.years
                    }
                }
            }
        }
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
