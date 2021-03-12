resource "aws_lb_target_group" "alb_target_group" {
    name = "${upper(var.caller)}-${var.name}"
    port = "${var.port}"
    protocol = "${var.protocol}"
    vpc_id = "${var.vpc}"
    deregistration_delay = "${var.dereg_delay}"
    slow_start = "${var.start_delay}"
    proxy_protocol_v2 = "${var.proxy_v2}"
    target_type = "${var.type}"
    dynamic "stickiness" {
        for_each = [for key in var.stickiness: {
            map = merge(local.defaults.stickiness,key)
        }]
        content {
            type = stickiness.value.map.type
            cookie_duration = stickiness.value.map.cookie_duration
            enabled = stickiness.value.map.enabled
        }
    }
    health_check {
        enabled = "${var.health_check}"
        interval = "${var.health_interval}"
        path = "${var.health_path}"
        port = "${var.health_port}"
        protocol = "${var.health_protocol}"
        timeout = "${var.health_timeout}"
        healthy_threshold = "${var.healthy_threshold}"
        unhealthy_threshold = "${var.unhealthy_threshold}"
        matcher = "${var.health_matcher}"
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
