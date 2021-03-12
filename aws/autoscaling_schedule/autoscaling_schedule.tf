resource "aws_autoscaling_schedule" "autoscaling_schedule" {
    autoscaling_group_name = var.autoscaling_group
    scheduled_action_name = "${upper(var.caller)}-${var.name}"
    start_time = var.start
    end_time = var.end
    recurrence = var.recurrence
    min_size = var.min
    max_size = var.max
    desired_capacity = var.capacity

    count = local.farm
}
