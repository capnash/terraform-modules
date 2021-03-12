resource "aws_elasticache_parameter_group" "cache_parameter_group" {
    name = "${upper(var.caller)}-${var.name}"
    family = "${var.family}"
    dynamic "parameter" {
        for_each = [for key in var.parameters: {
            map = merge(local.defaults.parameter,key)
        }]
        content {
            name = parameter.value.map.name
            value = parameter.value.map.value
        }
    }

    count = "${local.farm}"
}
