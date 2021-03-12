resource "aws_lb" "alb" {
    name = "${upper(var.caller)}-${var.name}"
    internal = "${var.internal}"
    load_balancer_type = "${var.type}"
    security_groups = "${var.sec_groups}"
    dynamic "access_logs" {
        for_each = [for key in var.logs: {
            map = merge(local.defaults.access_logs,key)
        }]
        content {
            bucket = access_logs.value.map.bucket
            enabled = access_logs.value.map.enabled
        }
    }
    subnets = "${var.subnets}"
    dynamic "subnet_mapping" {
        for_each = [for key in var.subnet_mapping: {
            map = merge(local.defaults.subnet_mapping,key)
        }]
        content {
            subnet_id = subnet_mapping.value.map.subnet_id
            allocation_id = subnet_mapping.value.map.allocation_id
        }
    }
    idle_timeout = "${var.timeout}"
    enable_deletion_protection = "${var.protected}"
    enable_http2 = "${var.http2}"
    ip_address_type = "${var.ip_type}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
