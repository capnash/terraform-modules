resource "aws_appautoscaling_policy" "app_autoscaling_policy" {
    name = "${var.caller}-${var.name}"
    policy_type = var.policy_type
    resource_id = var.resource_id
    scalable_dimension = var.dimension
    service_namespace = var.namespace

    dynamic "target_tracking_scaling_policy_configuration" {
        for_each = [for key in var.target_tracking_scaling_policy_configuration: {
            map = merge(local.defaults.target_tracking_scaling_policy_configuration, key)
        }]
        content {
            dynamic "predefined_metric_specification" {
                for_each = [for metricSpec in target_tracking_scaling_policy_configuration.value.map.predefined_metric_specification: {
                    specs = merge(local.defaults.predefined_metric_specification, metricSpec)
                }]
                content {
                    predefined_metric_type = predefined_metric_specification.value.specs.predefined_metric_type
                }
            }
            target_value = target_tracking_scaling_policy_configuration.value.map.target_value
        }
    }
}
