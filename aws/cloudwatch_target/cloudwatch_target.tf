resource "aws_cloudwatch_event_target" "cloudwatch_target" {
    rule = "${var.rule}"
    target_id = "${var.target_id}"
    arn = "${var.arn}"
    input = "${var.input}"
    input_path = "${var.input_path}"
    role_arn = "${var.role}"
    dynamic "run_command_targets" {
        for_each = [for key in var.run_params: {
            map = merge(local.defaults.run_params,key)
        }]
        content {
            key = run_command_targets.value.map.key
            values = run_command_targets.value.values
        }
    }
    dynamic "ecs_target" {
        for_each = [for key in var.ecs_params: {
            map = merge(local.defaults.ecs_params,key)
        }]
        content {
            group = ecs_target.value.map.group
            launch_type = ecs_target.value.map.launch_type
            platform_version = ecs_target.value.map.platform_version
            task_count = ecs_target.value.map.task_count
            task_definition_arn = ecs_target.value.map.task_definition_arn
            dynamic "network_configuration" {
                for_each = [for i in ecs_target.value.map.network_configuration: {
                    net = merge(local.defaults.ecs_network_config,i)
                }]
                content {
                    subnets = network_configuration.value.net.subnets
                    security_groups = network_configuration.value.net.security_groups
                    assign_public_ip = network_configuration.value.net.assign_public_ip
                }
            }
        }
    }
    dynamic "batch_target" {
        for_each = [for key in var.batch_params: {
            map = merge(local.defaults.batch_params,key)
        }]
        content {
            job_definition = batch_target.value.map.job_definition
            job_name = batch_target.value.map.job_name
            array_size = batch_target.value.map.array_size
            job_attempts = batch_target.value.map.job_attempts
        }
    }
    dynamic "kinesis_target" {
        for_each = [for key in var.kinesis_params: {
            map = merge(local.defaults.kinesis_params,key)
        }]
        content {
            partition_key_path = kinesis_target.value.map.partition_key_path
        }
    }
    dynamic "sqs_target" {
        for_each = [for key in var.sqs_params: {
            map = merge(local.defaults.sqs_params,key)
        }]
        content {
            message_group_id = sqs_target.value.map.message_group_id
        }
    }
    dynamic "input_transformer" {
        for_each = [for key in var.input_transformer: {
            map = merge(local.defaults.input_transformer,key)
        }]
        content {
            input_paths = input_transformer.value.map.input_paths
            input_template = input_transformer.value.map.input_template
        }
    }

    count = "${local.farm}"
}
