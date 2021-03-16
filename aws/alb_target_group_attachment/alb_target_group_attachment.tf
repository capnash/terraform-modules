resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
    target_group_arn = "${var.alb_target}"
    target_id = "${var.endpoint}"
    port = "${var.port}"
    availability_zone = "${var.a_z}"

    count = "${local.farm}"
}