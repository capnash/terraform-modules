output "id" {
    value = "${element(concat(aws_api_gateway_rest_api_policy.api_gateway_rest_api_policy.*.id,list("")),0)}"
}