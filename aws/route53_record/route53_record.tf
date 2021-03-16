resource "aws_route53_record" "route53_record" {
    zone_id = "${var.zone}"
    name = "${var.name}"
    type = "${var.type}"
    ttl = "${var.ttl}"
    records = "${var.records}"
    //multivalue_answer_routing_policy = "${var.multivalue_policy}"
    dynamic "alias" {
        for_each = [for key in var.alias: {
            map = merge(local.defaults.alias,key)
        }]
        content {
            name = alias.value.map.name
            zone_id = alias.value.map.zone_id
            evaluate_target_health = alias.value.map.evaluate_target_health
        }
    }
    /*
    dynamic "failover_routing_policy" {
        for_each = [for key in var.failover_routing_policy: {
            map = merge(local.defaults.failover_routing_policy,key)
        }]
        content {
            type = failover_routing_policy.value.map.type
        }
    }
    dynamic "geolocation_routing_policy" {
        for_each = [for key in var.geolocation_routing_policy: {
            map = merge(local.defaults.geolocation_routing_policy,key)
        }]
        content {
            continent = geolocation_routing_policy.value.map.continent
            country = geolocation_routing_policy.value.map.country
            subdivision = geolocation_routing_policy.value.map.subdivision
        }
    }
    dynamic "latency_routing_policy" {
        for_each = [for key in var.latency_routing_policy: {
            map = merge(local.defaults.latency_routing_policy,key)
        }]
        content {
            region = latency_routing_policy.value.map.region
        }
    }
    dynamic "weighted_routing_policy" {
        for_each = [for key in var.weighted_routing_policy: {
            map = merge(local.defaults.weighted_routing_policy,key)
        }]
        content {
            weight = weighted_routing_policy.value.map.weight
        }
    }
    */

    count = "${local.farm}"
}
