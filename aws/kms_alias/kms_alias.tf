resource "aws_kms_alias" "kms_alias" {
    name = "alias/${var.name}"
    target_key_id = "${var.kms}"

    count = "${local.farm}"
}