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
output "lambda_ecs_lifecycle_function_arn" {
   value = "${aws_lambda_function.ecs_lifecycle_function.arn}"
}

output "lambda_ecs_lifecycle_function_qualified_arn" {
   value = "${aws_lambda_function.ecs_lifecycle_function.qualified_arn}"
}

output "lambda_ecs_lifecycle_function_invoke_arn" {
   value = "${aws_lambda_function.ecs_lifecycle_function.invoke_arn}"
}

output "lambda_ecs_lifecycle_function_version" {
   value = "${aws_lambda_function.ecs_lifecycle_function.version}"
}

output "ecs_asg_notifications_group_names" {
  value = aws_autoscaling_notification.notifications.group_names
}

output "ecs_asg_notifications_notifications" {
  value = aws_autoscaling_notification.notifications.notifications
}

output "ecs_asg_notifications_topic_arn" {
  value = aws_autoscaling_notification.notifications.topic_arn
}

output "ecs_notification_sns_arn" {
  value = aws_sns_topic.ecs_notifications.arn
}

output "ecs_notification_sns_id" {
  value = aws_sns_topic.ecs_notifications.id
}

output "aws_sns_slack_subscription_id" {
  value = aws_sns_topic_subscription.ecs_slack_notifications.id
}

output "aws_sns_slack_subscription_arn" {
  value = aws_sns_topic_subscription.ecs_slack_notifications.arn
}
