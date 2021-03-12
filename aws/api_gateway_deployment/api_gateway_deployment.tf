resource "aws_api_gateway_deployment" "api_gateway_deployment" {
    rest_api_id = "${var.rest_api}"
    stage_name = "${var.stage}"
    description = "${var.description}"
    stage_description = "${var.stage_description}"
    triggers = "${var.triggers}"
    variables = "${var.env_vars}"

    count = "${local.farm}"
}
