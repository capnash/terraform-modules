resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-${var.tags["role"]}-sg"
  description = "The ALB SG for alb-${var.tags["role"]}"
  vpc_id      = var.vpc_id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, map("Name", "${var.environment}-alb-${var.tags["role"]}-sg")) 
}

#############
## Outputs ##
#############
output "security_group_id" {
  value = aws_security_group.alb.id
}

output "security_group_arn" {
  value = aws_security_group.alb.arn
}

output "security_group_name" {
  value = aws_security_group.alb.name
}