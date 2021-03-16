resource "aws_route53_zone_association" "route53_zone_association" {
    zone_id = "${var.zone}"
    vpc_id = "${var.vpc}"

    count = "${local.farm}"
}
