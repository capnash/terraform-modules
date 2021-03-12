resource "aws_iam_user" "iam_user" {
    name = "${upper(var.caller)}-${var.name}"
    path = "${var.path}"
    permissions_boundary = "${var.permissions_boundary}"
    force_destroy = "${var.force_destroy}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
