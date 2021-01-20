resource "aws_autoscaling_group" "asg" {
  name                      = "${var.environment}-aws-ecs-asg"
  max_size                  = var.asg_max
  min_size                  = var.asg_min

  desired_capacity          = var.asg_desired
  metrics_granularity       = var.metrics_granularity

  force_delete              = true
  
  health_check_grace_period = "0"
  health_check_type         = "EC2"
  
  launch_configuration      = aws_launch_configuration.launch.name
  availability_zones        = [data.aws_availability_zones.all.names]
  vpc_zone_identifier       = [var.private_subnets]

  tag {
    key                 = "Name"
    value               = "${var.environment}-aws-ecs"
    propagate_at_launch = true
  }
  tag {
    key                 = "role"
    value               = var.tags["role"]
    propagate_at_launch = true
  }
  tag {
    key                 = "environment"
    value               = var.tags["environment"]
    propagate_at_launch = true
  }
  tag {
    key                 = "location"
    value               = "aws"
    propagate_at_launch = true
  }
  tag {
    key                 = "terraform"
    value               = var.tags["terraform_version"]
    propagate_at_launch = true
  }
  tag {
    key                 = "owner"
    value               = var.tags["owner"]
    propagate_at_launch = true
  }
  tag {
    key                 = "service"
    value               = var.tags["service"]
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "ecs_terminating_hook" {
  name                   = "${var.environment}-ecs-terminating-hook"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  default_result         = "ABANDON"
  heartbeat_timeout      = 900
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"

  notification_target_arn = aws_sns_topic.ecs_lifecycle_topic.arn
  role_arn                = aws_iam_role.notifications_role.arn
}

#############
## Outputs ##
#############
output "autoscaling_group_ecs_id" {
  value = aws_autoscaling_group.asg.id
}
 
output "autoscaling_group_ecs_arn" {
  value = aws_autoscaling_group.asg.arn
}

output "autoscaling_group_ecs_name" {
  value = aws_autoscaling_group.asg.name
}
