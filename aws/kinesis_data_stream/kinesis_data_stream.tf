resource "aws_kinesis_stream" "kinesis_data_stream" {
    name = "${upper(var.caller)}-${var.name}"
    shard_count = "${var.shards}"
    retention_period = "${var.retention}"
    shard_level_metrics = "${var.metrics}"
    enforce_consumer_deletion = "${var.require_deregistration}"
    encryption_type = "${var.encryption}"
    kms_key_id = "${var.kms}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
