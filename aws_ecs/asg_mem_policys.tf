# scale up alarm
resource "aws_autoscaling_policy" "mem_policy_scale_out" {
  name                   = "${var.environment}-ecs-mem-policy-scale-out"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  
  adjustment_type       = var.mem_adjustment_type
  scaling_adjustment    = var.mem_scaling_adjustment
  cooldown              = var.mem_cooldown
  policy_type           = var.mem_policy_type
}

resource "aws_cloudwatch_metric_alarm" "mem_alarm_scale_out" {
  alarm_name            = "${var.environment}-ecs-mem-alarm-scale-out"
  alarm_description     = "${var.environment}-ecs-mem-alarm-scale-out"
  comparison_operator   = var.mem_scale_out_comparison_operator
  evaluation_periods    = var.mem_evaluation_periods
  
  metric_name = "MemoryReservation"
  namespace   = "AWS/ECS"
  period      = var.mem_period

  statistic = "Average"
  threshold = var.mem_scale_out_threshold
  
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.mem_policy_scale_out.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "mem_policy_scale_in" {
  name                   = "${var.environment}-ecs-mem-policy-scale-in"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  
  adjustment_type       = var.mem_adjustment_type
  scaling_adjustment    = var.mem_scaling_adjustment
  cooldown              = var.mem_cooldown
  policy_type           = var.mem_policy_type
}

resource "aws_cloudwatch_metric_alarm" "mem_alarm_scale_in" {
  alarm_name        = "${var.environment}-ecs-mem-alarm-scale-in"
  alarm_description = "${var.environment}-ecs-mem-alarm-scale-in"
  
  comparison_operator = var.mem_scale_in_comparison_operator
  evaluation_periods  = var.mem_evaluation_periods
  
  metric_name = "MemoryReservation"
  namespace   = "AWS/ECS"
  period      = var.mem_period
  
  statistic = "Average"
  threshold = var.mem_scale_in_threshold
  
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.mem_policy_scale_in.arn]
}

#############
## Outputs ##
#############
output "cloudwatch_metric_alarm_ecs_mem_scale_in_arn" {
  value = aws_cloudwatch_metric_alarm.mem_alarm_scale_in.arn
}

output "cloudwatch_metric_alarm_ecs_mem_scale_in_id" {
  value = aws_cloudwatch_metric_alarm.mem_alarm_scale_in.id
}

output "cloudwatch_metric_alarm_ecs_mem_scale_out_arn" {
  value = aws_cloudwatch_metric_alarm.mem_alarm_scale_out.arn
}

output "cloudwatch_metric_alarm_ecs_mem_scale_out_id" {
  value = aws_cloudwatch_metric_alarm.mem_alarm_scale_out.id
}

output "autoscaling_policy_ecs_mem_scale_in_arn" {
  value = aws_autoscaling_policy.mem_policy_scale_in.arn
}

output "autoscaling_policy_ecs_mem_scale_in_name" {
  value = aws_autoscaling_policy.mem_policy_scale_in.name
}

output "autoscaling_policy_ecs_mem_scale_in_policy_type" {
  value = aws_autoscaling_policy.mem_policy_scale_in.policy_type
}

output "autoscaling_policy_ecs_mem_scale_out_arn" {
  value = aws_autoscaling_policy.mem_policy_scale_out.arn
}

output "autoscaling_policy_ecs_mem_scale_out_name" {
  value = aws_autoscaling_policy.mem_policy_scale_out.name
}

output "autoscaling_policy_ecs_mem_scale_out_policy_type" {
  value = aws_autoscaling_policy.mem_policy_scale_out.policy_type
}