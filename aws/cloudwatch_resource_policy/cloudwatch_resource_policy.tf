resource "aws_cloudwatch_log_resource_policy" "cloudwatch_resource_policy" {
    policy_name = "${upper(var.caller)}-${var.name}"
    policy_document = var.policy

    count = local.farm
}