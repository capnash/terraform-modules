resource "aws_lb_listener" "http" {
  count             = (var.http_enabled == true && var.http_redirect_enabled == true) ? 1 : 0 
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_lb_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "http_no_redir" {
  count             = (var.http_enabled == true && var.http_redirect_enabled != true) ? 1 : 0 
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_lb_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.http.arn
    type             = "forward"
  }

}

resource "aws_lb_listener" "http_https" {
  count             = (var.http_enabled == true && var.http_redirect_enabled != true) ? 1 : 0 
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_port_external
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.cert_arn

  default_action {
    target_group_arn = aws_lb_target_group.http.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "https" {
  count             = var.https_enabled == true ? 1 : 0 
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_port_external
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.cert_arn

  default_action {
    target_group_arn = aws_lb_target_group.https.arn
    type             = "forward"
  }
}

#############
## Outputs ##
#############
output "alb_listener_http_id" {
   value = join(",", aws_lb_listener.http.*.id)
}

output "alb_listener_http_arn" {
   value = join(",", aws_lb_listener.http.*.arn)
}

output "alb_listener_https_id" {
   value = join(",", aws_lb_listener.https.*.id)
}

output "alb_listener_https_arn" {
   value = join(",", aws_lb_listener.https.*.arn)
}

output "alb_listener_http_https_arn" {
   value = join(",", aws_lb_listener.http_https.*.arn)
}

output "alb_listener_http_https_id" {
   value = join(",", aws_lb_listener.http_https.*.id)
}

output "alb_listener_http_no_redir_arn" {
   value = join(",", aws_lb_listener.http_no_redir.*.arn)
}

output "alb_listener_http_no_redir_id" {
   value = join(",", aws_lb_listener.http_no_redir.*.id)
}
