resource "aws_acm_certificate" "acm_certificate" {
    domain_name = "${var.domain}"
    subject_alternative_names = "${var.alt_names}"
    validation_method = "${var.validate}"
    tags = {
        Name = "${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
