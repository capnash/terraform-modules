resource "aws_secretsmanager_secret_version" "secret_version" {
    secret_id = "${var.key}"
    secret_string = "${var.secret}"
    version_stages = "${var.stages}"

    count = "${local.farm}"
}
