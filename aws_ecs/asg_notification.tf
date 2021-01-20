resource "aws_autoscaling_notification" "notifications" {
  group_names = [aws_autoscaling_group.asg.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.example.arn
}

resource "aws_sns_topic" "ecs_notifications" {
  name         = "${var.environment}-aws-ecs-cluster-notifications"
  display_name = "${var.environment}-aws-ecs-cluster-notifications"

  tags = merge(var.tags, map("Name", "${var.environment}-aws-ecs-cluster-notifications"))
}

resource "aws_sns_topic_subscription" "ecs_slack_notifications" {
  topic_arn = aws_sns_topic.ecs_notifications.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.ecs_sns_slack_function.arn
}

resource "aws_lambda_function" "ecs_sns_slack_function" {
  filename         = data.archive_file.slack_notifications.output_path
  function_name    = "${var.environment}-ecs-slack_notifications"
  description      = "send slack message from sns"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "snsToSlack.handler"
  source_code_hash = data.archive_file.slack_notifications.output_base64sha256
  runtime          = "Node.js 12.x"
  timeout          = "10"

  kms_key_arn      = var.lambda_kms_key_arn

  tags = merge(var.tags, map("Name", "${var.environment}-ecs-slack_notifications"))

  environment {
    variables = {
      CLUSTER             = aws_ecs_cluster.cluster.name
      SLACK_CHANNEL       = var.slack_channel
      SLACK_WEBHOOK_PATH  = var.slack_weebhook_path
    }
  }

  # lifecycle {
  #   ignore_changes = ["source_code_hash"]
  # }  
  
}

resource "aws_lambda_permission" "allow_sns" {
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.ecs_sns_slack_function.function_name
  principal      = "sns.amazonaws.com"
  source_arn     = aws_sns_topic.ecs_notifications.arn
}

#############
## Outputs ##
#############
output "autoscaling_notification_ecs_lifecycle_group_names" {
  value = aws_autoscaling_notification.notifications.group_names
}

output "autoscaling_notification_ecs_lifecycle_notifications" {
  value = aws_autoscaling_notification.notifications.notifications
}

output "autoscaling_notification_ecs_lifecycle_topic_arn" {
  value = aws_autoscaling_notification.notifications.topic_arn
}

output "sns_topic_ecs_notifications_arn" {
  value = aws_sns_topic.ecs_notifications.arn
}

output "sns_topic_ecs_notifications_id" {
  value = aws_sns_topic.ecs_notifications.id
}

output "sns_topic_subscription_slack_id" {
  value = aws_sns_topic_subscription.ecs_slack_notifications.id
}

output "sns_topic_subscription_slack_arn" {
  value = aws_sns_topic_subscription.ecs_slack_notifications.arn
}
