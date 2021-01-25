# ##### TAGS #####
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
}

variable "environment" {
  description = "Name of environment"
  type        = string
}

# ##### ALB #####
variable "public_subnets" {
  description = "The public subnet for ALB to be deployed into"
  type        = list
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = string
  default     = 60
}

variable "s3_logs_bucket" {
  description = "The bucket that ALB logs will be stored"
  type        = string
}

variable "s3_logs_prefix" {
  description = "The bucket prefix to store log files "
  type        = string
}

variable "internal" {
  description = "Internal facing ALB?"
  type        = bool
  default     = false
}

variable "drop_headers" {
  description = "Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer."
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer."
  type        = bool
  default     = true
}

# ##### https listener #####
variable "ssl_policy" {
  description = "The name of the SSL Policy for the listener. Required if protocol is HTTPS."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "cert_arn" {
  description = "The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS."
  type        = string
}

##### https tg #####
variable "https_deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds"
  type        = string
  default     = 300
}

variable "http_deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds"
  type        = string
  default     = 300
}

variable "vpc_id" {
  description = "the vpc id to add target group to"
  type        = string
}

variable "http_redirect_enabled" {
  description = "Enable redirection from HTTP to HTTPS"
  type        = bool
  default     = false
}

variable "http_enabled" {
  description = "Enable HTTP entry point for the application"
  type        = bool
  default     = false
}

variable "http_port" {
  description = "Port for HTTP to run on, default is 80"
  type        = string
  default     = 80
}

variable "http_hc_protocol" {
  description = "The protocol to use to connect with the target"
  type        = string
  default     = "HTTP"
}

variable "http_hc_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  type        = string
  default     = 10
}

variable "http_hc_path" {
  description = "The destination for the health check request"
  type        = string
  default     = "/healthcheck"
}

variable "http_hc_port" {
  description = "The port to use to connect with the target"
  type        = string
  default     = 80
}

variable "http_hc_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. For Application Load Balancers, the range is 2 to 60 seconds"
  type        = string
  default     = 2
}

variable "http_hc_healthy" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = string
  default     = 3
}

variable "http_hc_unhealthy" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  type        = string
  default     = 5
}

variable "http_hc_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target."
  type        = string
  default     = 200
}

# ##### https tg #####
variable "https_enabled" {
  description = "Enable HTTPS entry point for the application"
  type        = bool
  default     = true
}

variable "https_port" {
  description = "Port for HTTPS to run on, default is 443, this is what the tagart group uses"
  type        = string
  default     = 443
}

variable "https_port_external" {
  description = "Port for HTTPS to run on, default is 443, this is what the ALB uses"
  type        = string
  default     = 443
}

variable "https_cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds)"
  type        = string
  default     = 86400
}

variable "https_stickiness_enabled" {
  description = "Boolean to enable / disable stickiness. Default is false"
  type        = string
  default     = false
}

variable "https_hc_protocol" {
  description = "The protocol to use to connect with the target"
  type        = string
  default     = "HTTPS"
}

variable "https_hc_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  type        = string
  default     = 5
}

variable "https_hc_path" {
  description = "The destination for the health check request"
  type        = string
  default     = "/healthcheck"
}

variable "https_hc_port" {
  description = "The port to use to connect with the target"
  type        = string
  default     = 443
}

variable "https_hc_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. For Application Load Balancers, the range is 2 to 60 seconds"
  type        = string
  default     = 2
}

variable "https_hc_healthy" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = string
  default     = 3
}

variable "https_hc_unhealthy" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  type        = string
  default     = 5
}

variable "https_hc_matcher" {
  description = "The HTTPS codes to use when checking for a successful response from a target."
  type        = string
  default     = 200
}

variable "http_lb_port" {
  description = "Port for HTTP to run on, default is 80"
  type        = string
  default     = 80
}

variable "http_cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds)"
  type        = string
  default     = 86400
}

variable "http_stickiness_enabled" {
  description = "Boolean to enable / disable stickiness. Default is false"
  type        = bool
  default     = false
}

# xtra sg part
variable "xtra_sg" {
  description = "xtra security group for alb , used by nr ip updates"
  type        = list
  default     = []
}

