output "arn" {
    value = "${element(concat(aws_acm_certificate.acm_certificate.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_acm_certificate.acm_certificate.*.id,list("")),0)}"
}

output "domain_name" {
    value = "${element(concat(aws_acm_certificate.acm_certificate.*.domain_name,list("")),0)}"
}

output "dvo" {
    value = "${aws_acm_certificate.acm_certificate.*.domain_validation_options}"
}