resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
    user = "${var.user}"
    policy_arn = "${var.policy}"

    count = "${local.farm}"
}
