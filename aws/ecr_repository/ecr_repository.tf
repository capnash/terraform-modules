resource "aws_ecr_repository" "ecr_repository" {
    name = "${lower(var.svc)}/${lower(var.name)}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
