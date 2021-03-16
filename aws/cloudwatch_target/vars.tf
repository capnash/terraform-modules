variable "caller" {}

variable "envname" {
    default = []
}

variable "rule" {}

variable "target_id" {
    default = null
}

variable "arn" {}

variable "input" {
    default = null
}

variable "input_path" {
    default = null
}

variable "role" {
    default = null
}

variable "run_params" {
    default = []
}

variable "ecs_params" {
    default = []
}

variable "batch_params" {
    default = []
}

variable "kinesis_params" {
    default = []
}

variable "sqs_params" {
    default = []
}

variable "input_transformer" {
    default = []
}

locals {
    defaults = {
        run_params = {
            key = ""
            values = []
        }
        ecs_params = {
            group = null
            launch_type = null
            platform_version = null
            task_count = null
            task_definition_arn = ""
            network_configuration = []
        }
        ecs_network_config = {
            subnets = []
            security_groups = []
            assign_public_ip = false
        }
        batch_params = {
            job_definition = ""
            job_name = ""
            array_size = null
            job_attempts = null
        }
        kinesis_params = {
            partition_key_path = null
        }
        sqs_params = {
            message_group_id = null
        }
        input_transformer = {
            input_paths = null
            input_template = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
