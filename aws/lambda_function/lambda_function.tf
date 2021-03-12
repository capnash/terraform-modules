resource "aws_lambda_function" "lambda_function" {
    function_name = "${upper(var.caller)}-${var.name}"
    role = "${var.iam_role}"
    runtime = "${var.runtime}"
    filename = "${var.file}"
    s3_bucket = "${var.bucket}"
    s3_key = "${var.path}"
    s3_object_version = "${var.object_version}"
    dynamic "dead_letter_config" {
        for_each = [for key in var.dead_letter: {
            map = merge(local.defaults.dead_letter_config,key)
        }]
        content {
            target_arn = dead_letter_config.value.map.target_arn
        }
    }
    description = "${var.description}"
    handler = "${var.handle}"
    layers = "${var.layers}"
    memory_size = "${var.mem_limit}"
    timeout = "${var.timeout}"
    reserved_concurrent_executions = "${var.threads}"
    publish = "${var.publish}"
    kms_key_arn = "${var.kms_key}"
    source_code_hash = "${var.hash}"
    dynamic "vpc_config" {
        for_each = [for key in var.vpc_config: {
            map = merge(local.defaults.vpc_config,key)
        }]
        content {
            subnet_ids = vpc_config.value.map.subnet_ids
            security_group_ids = vpc_config.value.map.security_group_ids
        }
    }
    dynamic "environment" {
        for_each = [for key in var.env_vars: {
            map = key
        }]
        content {
            variables = environment.value.map
        }
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
    lifecycle {
        ignore_changes = [
            last_modified
        ]
    }
}
