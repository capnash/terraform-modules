resource "aws_autoscaling_policy" "autoscaling_policy" {
    name = "${upper(var.caller)}-${var.name}"
    autoscaling_group_name = var.autoscaling_group
    adjustment_type = var.adjustment_type
    policy_type = var.policy_type
    estimated_instance_warmup = var.estimated_instance_warmup
    min_adjustment_magnitude = var.min_adjustment_magnitude
    cooldown = var.cooldown
    scaling_adjustment = var.scaling_adjustment
    metric_aggregation_type = var.metric_aggregation_type
    dynamic "step_adjustment" {
        for_each = [for key in var.step_adjustment:{
            map = merge(local.defaults.step_adjustment,key)
        }]
        content {
            scaling_adjustment = step_adjustment.value.map.scaling_adjustment
            metric_interval_lower_bound = step_adjustment.value.map.metric_interval_lower_bound
            metric_interval_upper_bound = step_adjustment.value.map.metric_interval_upper_bound
        }
    }
    dynamic "target_tracking_configuration" {
        for_each = [for key in var.target_tracking_configuration:{
            map = merge(local.defaults.target_tracking_configuration,key)
        }]
        content {
            dynamic "predefined_metric_specification" {
                for_each = [for pr in target_tracking_configuration.value.map.predefined_metric_specification:{
                    prd = merge(local.defaults.predefined_metric_specification,pr)
                }]
                content {
                    predefined_metric_type = predefined_metric_specification.value.prd.predefined_metric_type
                    resource_label = predefined_metric_specification.value.prd.resource_label
                }
            }
            dynamic "customized_metric_specification" {
                for_each = [for cu in target_tracking_configuration.value.map.customized_metric_specification:{
                    cus = merge(local.defaults.customized_metric_specification,cu)
                }]
                dynamic "metric_dimension" {
                    for_each = [for met in customized_metric_specification.value.cus.metric_dimension: {
                        dim = merge(local.defaults.metric_dimension,met)
                    }]
                    content {
                        name = metric_dimension.value.dim.name
                        value = metric_dimension.value.dim.value
                    }
                }
                metric_name = "${upper(var.caller)}-${customized_metric_specification.value.cus.metric_name}"
                namespace = customized_metric_specification.value.cus.namespace
                statistic = customized_metric_specification.value.cus.statistic
                unit = customized_metric_specification.value.cus.unit
            }
            target_value = target_tracking_configuration.value.map.target_value
            disable_scale_in = target_tracking_configuration.value.map.disable_scale_in
        }
    }

    count = local.farm
}