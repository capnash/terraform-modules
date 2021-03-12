resource "aws_api_gateway_response" "api_gateway_response" {
    rest_api_id = "${var.rest_api}"
    response_type = "${var.type}"
    status_code = "${var.status_code}"
    response_templates = "${var.response_templates}"
    response_parameters = "${var.response_parameters}"

    count = "${local.farm}"
}