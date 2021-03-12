resource "aws_iam_service_linked_role" "iam_service_linked_role" {
    aws_service_name = "${var.aws_service}"
    custom_suffix = "${var.suffix}"
    description = "${var.description}"

    count = "${local.farm}"
}
