resource "aws_sns_topic_subscription" "ecs_lifecycle_subscription" {
  topic_arn = aws_sns_topic.ecs_lifecycle_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.ecs_lifecycle_function.arn
}


resource "aws_sns_topic" "ecs_lifecycle_topic" {
  name_prefix  = "${var.name}-ecs-lifecycle-"
  display_name = "${var.name}-ecs-lifecycle-topic"
}

#############
## Outputs ##
#############
output "sns_ecs_lifecycle_subscription_id" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.id}"
}

output "sns_ecs_lifecycle_subscription_topic_arn" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.topic_arn}"
}

output "sns_ecs_lifecycle_subscription_endpoint" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.endpoint}"
}

output "sns_ecs_lifecycle_subscription_arn" {
  value = "${aws_sns_topic_subscription.ecs_lifecycle_subscription.arn}"
}

output "sns_ecs_lifecycle_topic_id" {
  value = "${aws_sns_topic.ecs_lifecycle_topic.id}"
}

output "sns_ecs_lifecycle_topic_arn" {
  value = "${aws_sns_topic.ecs_lifecycle_topic.arn}"
}