resource "aws_iam_role" "iam_role" {
    name = "${var.name}"
    assume_role_policy = "${var.policy}"
    force_detach_policies = "${var.purge_policies}"
    path = "${var.iam_path}"
    permissions_boundary = "${var.perm_bound}"
    tags = {
        Name = "${var.name}"
        Description = "${var.description}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
