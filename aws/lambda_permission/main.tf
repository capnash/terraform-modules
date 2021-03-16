resource "aws_lambda_permission" "lambda_permission" {
    action = "${var.action}"
    event_source_token = "${var.source_token}"
    function_name = "${var.function}"
    principal = "${var.trust}"
    qualifier = "${var.qualifier}"
    source_account = "${var.account}"
    source_arn = "${var.source_arn}"
    statement_id = "${var.name}"
    
    count = "${local.farm}"
}
