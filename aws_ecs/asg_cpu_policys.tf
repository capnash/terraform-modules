# scale up alarm
resource "aws_autoscaling_policy" "cpu_policy_scale_out" {
  name                   = "${var.environment}-ecs-cpu-policy-scale-out"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  
  adjustment_type       = var.cpu_adjustment_type
  scaling_adjustment    = var.cpu_scaling_out_adjustment
  cooldown              = var.cpu_cooldown
  policy_type           = var.cpu_policy_type
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scale_out" {
  alarm_name            = "${var.environment}-ecs-cpu-alarm-scale-out"
  alarm_description     = "${var.environment}-ecs-cpu-alarm-scale-out"
  comparison_operator   = var.cpu_scale_out_comparison_operator
  evaluation_periods    = var.cpu_evaluation_periods
  
  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = var.cpu_period

  statistic = "Average"
  threshold = var.cpu_scale_out_threshold
  
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.cpu_policy_scale_out.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "cpu_policy_scale_in" {
  name                   = "${var.environment}-ecs-cpu-policy-scale-in"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  
  adjustment_type       = var.cpu_adjustment_type
  scaling_adjustment    = var.cpu_scaling_in_adjustment
  cooldown              = var.cpu_cooldown
  policy_type           = var.cpu_policy_type
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scale_in" {
  alarm_name        = "${var.environment}-ecs-cpu-alarm-scale-in"
  alarm_description = "${var.environment}-ecs-cpu-alarm-scale-in"
  
  comparison_operator = var.cpu_scale_in_comparison_operator
  evaluation_periods  = var.cpu_evaluation_periods
  
  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = var.cpu_period
  
  statistic = "Average"
  threshold = var.cpu_scale_in_threshold
  
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu_policy_scale_in.arn]
}

#############
## Outputs ##
#############
output "cloudwatch_metric_alarm_ecs_cpu_scale_in_arn" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm_scale_in.arn
}

output "cloudwatch_metric_alarm_ecs_cpu_scale_in_id" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm_scale_in.id
}

output "cloudwatch_metric_alarm_ecs_cpu_scale_out_arn" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm_scale_out.arn
}

output "cloudwatch_metric_alarm_ecs_cpu_scale_out_id" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm_scale_out.id
}

output "autoscaling_policy_ecs_cpu_scale_in_arn" {
  value = aws_autoscaling_policy.cpu_policy_scale_in.arn
}

output "autoscaling_policy_ecs_cpu_scale_in_name" {
  value = aws_autoscaling_policy.cpu_policy_scale_in.name
}

output "autoscaling_policy_ecs_cpu_scale_in_policy_type" {
  value = aws_autoscaling_policy.cpu_policy_scale_in.policy_type
}

output "autoscaling_policy_ecs_cpu_scale_out_arn" {
  value = aws_autoscaling_policy.cpu_policy_scale_out.arn
}

output "autoscaling_policy_ecs_cpu_scale_out_name" {
  value = aws_autoscaling_policy.cpu_policy_scale_out.name
}

output "autoscaling_policy_ecs_cpu_scale_out_policy_type" {
  value = aws_autoscaling_policy.cpu_policy_scale_out.policy_type
}