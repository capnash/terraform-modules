output "name" {
    value = "${element(concat(aws_lambda_function.lambda_function.*.function_name,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_lambda_function.lambda_function.*.arn,list("")),0)}"
}

output "qualified_arn" {
    value = "${element(concat(aws_lambda_function.lambda_function.*.qualified_arn,list("")),0)}"
}

output "invoke_arn" {
    value = "${element(concat(aws_lambda_function.lambda_function.*.invoke_arn,list("")),0)}"
}

output "version" {
    value = "${element(concat(aws_lambda_function.lambda_function.*.version,list("")),0)}"
}

output "api" {
    value = "${element(concat(aws_lambda_function.lambda_function.*.invoke_arn,list("")),0)}"
}
