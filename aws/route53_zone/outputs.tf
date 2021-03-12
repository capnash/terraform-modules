output "id" {
    value = "${element(concat(aws_route53_zone.route53_zone.*.zone_id,list("")),0)}"
}
