resource "aws_api_gateway_rest_api_policy" "api_gateway_rest_api_policy" {
  rest_api_id = var.rest_api_id
  policy = var.policy
  count = "${local.farm}"
}