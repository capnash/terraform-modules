resource "aws_security_group" "instance" {
  name        = "${var.name}-sg-instances"
  vpc_id      = var.vpc_id
  description = "Used for ecs sg for ${var.tags["role"]}"
  tags        = "${merge(var.tags, map("Name", format("%s-sg-instances", var.name)))}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "alb_to_ecs" {
   type                     = "ingress"
   from_port                = 0
   to_port                  = 65535
   protocol                 = "TCP"
   description              = "Allows ALB to talk to ECS contianters"
   source_security_group_id = var.alb_sg_id
   security_group_id        = aws_security_group.instance.id
}

#############
## Outputs ##
#############
output "sg_ecs_instance_id" {
  value = "${aws_security_group.instance.id}"
}

output "sg_ecs_instance_name" {
  value = "${aws_security_group.instance.name}"
}

output "sg_ecs_instance_arn" {
  value = "${aws_security_group.instance.arn}"
}