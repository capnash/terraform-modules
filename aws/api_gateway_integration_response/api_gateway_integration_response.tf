resource "aws_api_gateway_integration_response" "api_gateway_integration_response" {
    rest_api_id = "${var.rest_api}"
    resource_id = "${var.resource_id}"
    http_method = "${var.http_method}"
    status_code = "${var.status_code}"
    selection_pattern = "${var.selection_pattern}"
    response_templates = "${var.response_templates}"
    response_parameters = "${var.response_parameters}"
    content_handling = "${var.content}"

    count = "${local.farm}"
}