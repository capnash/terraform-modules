output "id" {
    value = "${element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.id,list("")),0)}"
}

output "url" {
    value = "${element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.invoke_url,list("")),0)}"
}

output "execution_arn" {
    value = "${element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.execution_arn,list("")),0)}"
}
