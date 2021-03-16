output "id" {
    value = "${element(concat(aws_api_gateway_stage.api_gateway_stage.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_api_gateway_stage.api_gateway_stage.*.arn,list("")),0)}"
}

output "execution_arn" {
    value = "${element(concat(aws_api_gateway_stage.api_gateway_stage.*.execution_arn,list("")),0)}"
}

output "url" {
    value = "${element(concat(aws_api_gateway_stage.api_gateway_stage.*.invoke_url,list("")),0)}"
}
