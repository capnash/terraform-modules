resource "aws_autoscaling_lifecycle_hook" "autoscaling_lifecycle_hook" {
    name = "${var.caller}-${var.name}"
    autoscaling_group_name = var.autoscaling_group
    default_result = var.default_result
    heartbeat_timeout = var.timeout
    lifecycle_transition = var.lifecycle_transition
    notification_metadata = var.notification_metadata
    notification_target_arn = var.notification_target
    role_arn = var.role

    count = local.farm
}
