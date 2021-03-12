variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "zone" {}

variable "type" {
    default = "A"
}

variable "ttl" {
    default = null
}

variable "records" {
    default = null
}

variable "alias" {
    default = []
}

/*
variable "multivalue_policy" {
    default = null
}

variable "failover_routing_policy" {
    default = []
}

variable "geolocation_routing_policy" {
    default = []
}

variable "latency_routing_policy" {
    default = []
}

variable "weighted_routing_policy" {
    default = []
}
*/

locals {
    defaults = {
        alias = {
            name = ""
            zone_id = ""
            evaluate_target_health = false
        }
        failover_routing_policy = {
            type = "PRIMARY"
        }
        geolocation_routing_policy = {
            continent = null
            country = null
            subdivision = null
        }
        latency_routing_policy = {
            region = "us-east-1"
        }
        weighted_routing_policy = {
            weight = 1
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
