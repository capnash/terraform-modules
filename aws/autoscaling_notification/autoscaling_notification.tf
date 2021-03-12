resource "aws_autoscaling_notification" {
    group_names = var.autoscaling_groups
    notifications = var.notifications
    topic_arn = var.topic

    count = local.farm
}