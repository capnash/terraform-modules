variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "autoscaling_group" {}

variable "adjustment_type" {
    default = null
}

variable "policy_type" {
    default = "SimpleScaling"
}

variable "estimated_instance_warmup" {
    default = null
}

variable "min_adjustment_magnitude" {
    default = null
}

variable "cooldown" {
    default = null
}

variable "scaling_adjustment" {
    default = null
}

variable "metric_aggregation_type" {
    default = null
}

variable "step_adjustment" {
    default = []
}

variable "target_tracking_configuration" {
    default = []
}

locals {
    defaults = {
        step_adjustment = {
            scaling_adjustment = 1
            metric_interval_lower_bound = null
            metric_interval_upper_bound = null
        }
        target_tracking_configuration = {
            predefined_metric_specification = []
            customized_metric_specification = []
            target_value = 2
            disable_scale_in = false
        }
        predefined_metric_specification = {
            predefined_metric_type = ""
            resource_label = null
        }
        customized_metric_specification = {
            metric_dimension = []
            metric_name = "${var.name}-Metric"
            namespace = ""
            statistic = ""
            unit = null
        }
        metric_dimension = {
            name = ""
            value = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}