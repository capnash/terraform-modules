resource "aws_redshift_parameter_group" "redshift_parameter_group" {
    name = "${var.caller}-${var.name}"
    description = var.description
    family = var.family
    dynamic "parameter" {
        for_each = [for key in var.parameters:{
            map = merge(local.defaults.parameter,key)
        }]
        content {
            name = parameter.value.map.name
            value = parameter.value.map.value
            tags = {
                Name = parameter.value.map.name
                Description = var.description
                Environment = var.caller
                Service = var.svc
            }
        }
    }

    count = local.farm
}