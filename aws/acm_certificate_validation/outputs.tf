output "id" {
    value = "${element(concat(aws_acm_certificate_validation.acm_validator.*.id,list("")),0)}"
}
