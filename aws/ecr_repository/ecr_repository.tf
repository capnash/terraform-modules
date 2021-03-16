resource "aws_ecr_repository" "ecr_repository" {
    name = "${lower(var.svc)}/${lower(var.name)}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
