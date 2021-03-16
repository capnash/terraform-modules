variable "caller" {}

variable "envname" {
    default = []
}

variable "name" {}

variable "description" {}

variable "svc" {
    default = "Created by Terraform"
}

variable "port" {
    default = null
}

variable "protocol" {
    default = null
}

variable "vpc" {
    default = null
}

variable "dereg_delay" {
    default = 300
}

variable "start_delay" {
    default = 0
}

variable "lambda_headers" {
    default = null
}

variable "proxy_v2" {
    default = "false"
}

variable "stickiness" {
    default = []
}

variable "type" {
    default = null
}

variable "health_check" {
    default = true
}

variable "health_interval" {
    default = 5
}

variable "health_path" {
    default = null
}

variable "health_port" {
    default = "traffic-port"
}

variable "health_protocol" {
    default = null
}

variable "health_timeout" {
    default = 3
}

variable "healthy_threshold" {
    default = 2
}

variable "unhealthy_threshold" {
    default = 3
}

variable "health_matcher" {
    default = null
}

locals {
    defaults = {
        stickiness = {
            type = "lb_cookie"
            cookie_duration = null
            enabled = true
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
