resource "aws_lb" "alb" {
  name            = "${var.environment}-alb-${var.tags["role"]}"
  internal        = var.internal
  subnets         = [var.public_subnets]
  idle_timeout    = var.idle_timeout

  drop_invalid_header_fields = var.drop_headers
  enable_http2               = var.enable_http2


  security_groups = [concat(list("${aws_security_group.alb.id}"), var.xtra_sg)]
  enable_deletion_protection = false

  access_logs {
    bucket  = var.s3_logs_bucket
    prefix  = var.s3_logs_prefix
    enabled = true
  }

  tags = merge(var.tags, map("Name", "${var.environment}-alb-${var.tags["role"]}"))
}

#############
## Outputs ##
#############
output "alb_id" {
   value = aws_lb.alb.id
}

output "alb_name" {
   value = aws_lb.alb.name
}

output "alb_arn" {
   value = aws_lb.alb.arn
}

output "alb_arn_suffix" {
   value = aws_lb.alb.arn_suffix
}

output "alb_dns_name" {
   value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
   value = aws_lb.alb.zone_id
}