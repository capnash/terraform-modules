resource "aws_autoscaling_policy" "schedule_scale_in_policy" {
  name                   = "${var.environment}-ecs-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_policy" "schedule_scale_out_policy" {
  name                   = "${var.environment}-ecs-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_schedule" "scaleout" {
  count                  = var.scale_out_time!= "none" ? 1 : 0
  scheduled_action_name  = "scale_out"
  max_size               = var.asg_max
  min_size               = var.asg_min
  desired_capacity       = var.asg_desired
  recurrence			       = var.scale_out_time
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_schedule" "scalein" {
  count                  = var.scale_in_time!= "none" ? 1 : 0
  scheduled_action_name  = "scale_in"
  max_size               = 0
  min_size               = 0
  desired_capacity       = 0
  recurrence			       = var.scale_in_time
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_lambda_function" "ecs_lifecycle_function" {
  filename         = data.archive_file.ecs_lifecycle_function.output_path
  function_name    = "${var.environment}-ecs-lifecycle-lambda"
  description      = ""
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.ecs_lifecycle_function.output_base64sha256
  runtime          = "python3.6"
  timeout          = "10"

  kms_key_arn      = var.lambda_kms_key_arn

  tags = merge(var.tags, map("Name", "${var.environment}-ecs-lifecycle-lambda"))

  environment {
    variables = {
      CLUSTER = aws_ecs_cluster.cluster.name
    }
  }

  # lifecycle {
  #   ignore_changes = ["source_code_hash"]
  # }  
  
}

resource "aws_lambda_permission" "ecs_lifecycle_allow_sns" {
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.ecs_lifecycle_function.function_name
  principal      = "sns.amazonaws.com"
  source_arn     = aws_sns_topic.ecs_lifecycle_topic.arn
}

resource "aws_sns_topic_subscription" "ecs_lifecycle_subscription" {
  topic_arn = aws_sns_topic.ecs_lifecycle_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.ecs_lifecycle_function.arn
}


resource "aws_sns_topic" "ecs_lifecycle_topic" {
  name_prefix  = "${var.environment}-ecs-lifecycle-"
  display_name = "${var.environment}-ecs-lifecycle-topic"
}

#############
## Outputs ##
#############
output "sns_topic_subscription_lifecycle_id" {
  value = aws_sns_topic_subscription.ecs_lifecycle_subscription.id
}

output "sns_topic_subscription_lifecycle_topic_arn" {
  value = aws_sns_topic_subscription.ecs_lifecycle_subscription.topic_arn
}

output "sns_topic_subscription_lifecycle_endpoint" {
  value = aws_sns_topic_subscription.ecs_lifecycle_subscription.endpoint
}

output "sns_topic_subscription_lifecycle_arn" {
  value = aws_sns_topic_subscription.ecs_lifecycle_subscription.arn
}

output "sns_topic_ecs_lifecycle_topic_id" {
  value = aws_sns_topic.ecs_lifecycle_topic.id
}

output "sns_topic_ecs_lifecycle_topic_arn" {
  value = aws_sns_topic.ecs_lifecycle_topic.arn
}

output "lambda_function_ecs_lifecycle_arn" {
   value = aws_lambda_function.ecs_lifecycle_function.arn
}

output "lambda_function_ecs_lifecycle_qualified_arn" {
   value = aws_lambda_function.ecs_lifecycle_function.qualified_arn
}

output "lambda_function_ecs_lifecycle_invoke_arn" {
   value = aws_lambda_function.ecs_lifecycle_function.invoke_arn
}

output "lambda_function_ecs_lifecycle_version" {
   value = aws_lambda_function.ecs_lifecycle_function.version
}

output "autoscaling_policy_schedule_in_arn" {
  value = aws_autoscaling_policy.schedule_scale_in_policy.arn
}

output "autoscaling_policy_schedule_in_name" {
  value = aws_autoscaling_policy.schedule_scale_in_policy.name
}

output "autoscaling_policy_schedule_in_policy_type" {
  value = aws_autoscaling_policy.schedule_scale_in_policy.policy_type
}

output "autoscaling_policy_schedule_out_arn" {
  value = aws_autoscaling_policy.schedule_scale_out_policy.arn
}

output "autoscaling_policy_schedule_out_name" {
  value = aws_autoscaling_policy.schedule_scale_out_policy.name
}

output "autoscaling_policy_schedule_out_policy_type" {
  value = aws_autoscaling_policy.schedule_scale_out_policy.policy_type
}

output "autoscaling_schedule_out_arn" {
  value = aws_autoscaling_schedule.scaleout.arn
}

output "autoscaling_schedule_in_arn" {
  value = aws_autoscaling_schedule.scalein.arn
}