resource "aws_iam_user" "iam_user" {
    name = "${var.caller}-${var.name}"
    path = "${var.path}"
    permissions_boundary = "${var.permissions_boundary}"
    force_destroy = "${var.force_destroy}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
