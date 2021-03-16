output "arn" {
    value = "${element(concat(aws_dms_endpoint.dms_endpoint.*.endpoint_arn,list("")),0)}"
}