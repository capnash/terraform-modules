resource "aws_appautoscaling_target" "app_autoscaling_target" {
    max_capacity = var.max
    min_capacity = var.min
    resource_id = var.resource_id
    role_arn = var.role
    scalable_dimension = var.dimension
    service_namespace = var.namespace

    count = local.farm
}