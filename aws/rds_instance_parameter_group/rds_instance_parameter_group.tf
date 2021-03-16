resource "aws_db_parameter_group" "rds_instance_parameter_group" {
    name = "${lower(var.caller)}-${lower(var.name)}"
    family = "${var.family}"
    description = "${var.description}"
    dynamic "parameter" {
        for_each = [for key in var.parameters:{
            map = merge(local.defaults.parameter,key)
        }]
        content {
            name = parameter.value.map.name
            value = parameter.value.map.value
            apply_method = parameter.value.map.apply_method
        }
    }
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
