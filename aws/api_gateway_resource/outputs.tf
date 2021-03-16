output "id" {
    value = "${element(concat(aws_api_gateway_resource.api_gateway_resource.*.id,list("")),0)}"
}

output "path" {
    value = "${element(concat(aws_api_gateway_resource.api_gateway_resource.*.path,list("")),0)}"
}
