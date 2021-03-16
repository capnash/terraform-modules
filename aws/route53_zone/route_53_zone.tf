resource "aws_route53_zone" "route53_zone" {
    name = "${var.name}"
    comment = "${var.description}"
    force_destroy = "${var.force_destroy}"
    dynamic "vpc" {
        for_each = [for key in var.vpc:{
            map = merge(local.defaults.vpc,key)
        }]
        content {
            vpc_id = vpc.value.map.vpc_id
            vpc_region = vpc.value.map.vpc_region
        }
    }
    tags = {
        Name = "${var.name} Domain"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
