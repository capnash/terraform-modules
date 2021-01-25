resource "aws_lb_target_group" "http" {
  count    = var.http_enabled == true ? 1 : 0 
  name     = "${var.environment}-alb-${var.tags["role"]}-http-tg"
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id


  deregistration_delay = var.http_deregistration_delay
  target_type          = "instance"


  stickiness {
    type            = "lb_cookie" 
    cookie_duration = var.http_cookie_duration
    enabled         = var.http_stickiness_enabled

  }

  health_check {
    protocol              = var.http_hc_protocol
    interval              = var.http_hc_interval
    path                  = var.http_hc_path
    port                  = var.http_hc_port
    timeout               = var.http_hc_timeout
    healthy_threshold     = var.http_hc_healthy
    unhealthy_threshold   = var.http_hc_unhealthy
    matcher               = var.http_hc_matcher
  }

  tags = merge(var.tags, map("Name", "${var.environment}-alb-${var.tags["role"]}-http-tg"))

}

resource "aws_lb_target_group" "https" {
  count    = var.https_enabled == true ? 1 : 0 
  name     = "${var.environment}-alb-${var.tags["role"]}-https-tg"
  port     = var.https_port
  protocol = "HTTPS"
  vpc_id   = var.vpc_id


  deregistration_delay  = var.https_deregistration_delay
  target_type           = "instance"


  stickiness {
    type            = "lb_cookie" 
    cookie_duration = var.https_cookie_duration
    enabled         = var.https_stickiness_enabled

  }

  health_check {
    protocol              = var.https_hc_protocol
    interval              = var.https_hc_interval
    path                  = var.https_hc_path
    port                  = var.https_hc_port
    timeout               = var.https_hc_timeout
    healthy_threshold     = var.https_hc_healthy
    unhealthy_threshold   = var.https_hc_unhealthy
    matcher               = var.https_hc_matcher
  }

  tags = merge(var.tags, map("Name", "${var.environment}-alb-${var.tags["role"]}-https-tg"))

}

#############
## Outputs ##
#############
output "alb_target_group_http_id" {
  value = join(",", aws_lb_target_group.http.*.id)
}

output "alb_target_group_http_arn" {
  value = join(",", aws_lb_target_group.http.*.arn)
}

output "alb_target_group_http_arn_suffix" {
  value = join(",", aws_lb_target_group.http.*.arn_suffix)
}

output "alb_target_group_http_name" {
  value = join(",", aws_lb_target_group.http.*.name)
}

output "alb_target_group_https_id" {
  value = join(",", aws_lb_target_group.https.*.id)
}

output "alb_target_group_https_arn" {
  value = join(",", aws_lb_target_group.https.*.arn)
}

output "alb_target_group_https_arn_suffix" {
  value = join(",", aws_lb_target_group.https.*.arn_suffix)
}

output "alb_target_group_https_name" {
  value = join(",", aws_lb_target_group.https.*.name)
}