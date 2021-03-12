resource "aws_docdb_cluster_parameter_group" "docdb_parameter_group" {
    family = "${var.family}"
    name = "${lower(var.caller)}-${lower(var.name)}"
    description = "${var.description}"
    dynamic "parameter" {
        for_each = [for key in var.parameters: {
            map = merge(local.defaults.parameter,key)
        }]
        content {
            name = parameter.value.map.name
            value = parameter.value.map.value
            apply_method = parameter.value.map.apply_method
        }
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
