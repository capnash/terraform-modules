resource "aws_cloudwatch_log_subscription_filter" "log_subscription_filter" {
    name = "${var.caller}-${var.name}"
    destination_arn = var.destination
    filter_pattern = var.filter_pattern
    log_group_name = var.log_group
    role_arn = var.role
    distribution = var.distribution

    count = local.farm
}
