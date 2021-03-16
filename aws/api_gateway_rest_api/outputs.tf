output "id" {
    value = "${element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.arn,list("")),0)}"
}

output "root" {
    value = "${element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.root_resource_id,list("")),0)}"
}

output "execution_arn" {
    value = "${element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.execution_arn,list("")),0)}"
}
