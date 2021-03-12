output "name" {
    value = "${element(concat(aws_route53_record.route53_record.*.name,list("")),0)}"
}

output "dns_name" {
    value = "${element(concat(aws_route53_record.route53_record.*.fqdn,list("")),0)}"
}
