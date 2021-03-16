resource "aws_lb_listener_certificate" "alb_listener_certificate" {
    listener_arn = "${var.listener}"
    certificate_arn = "${var.certificate}"

    count = "${local.farm}"
}