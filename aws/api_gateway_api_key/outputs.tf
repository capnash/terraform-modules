output "id" {
    value = "${element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.arn,list("")),0)}"
}

output "value" {
    value = "${element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.value,list("")),0)}"
}

output "root" {
    value = "${element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.root_resource_id,list("")),0)}"
}
