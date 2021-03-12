resource "aws_iam_policy" "iam_policy" {
    name = "${var.name}"
    description = "${var.description}"
    policy = "${var.policy}"
    path = "${var.path}"

    count = "${local.farm}"
}
