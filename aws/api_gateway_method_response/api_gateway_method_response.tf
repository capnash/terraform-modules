resource "aws_api_gateway_method_response" "api_gateway_method_response" {
    rest_api_id = "${var.rest_api}"
    resource_id = "${var.resource_id}"
    http_method = "${var.http_method}"
    status_code = "${var.status_code}"
    response_models = "${var.response_models}"
    response_parameters = "${var.response_parameters}"

    count = "${local.farm}"
}