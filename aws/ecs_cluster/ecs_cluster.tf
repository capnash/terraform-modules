resource "aws_ecs_cluster" "ecs_cluster" {
    name = "${var.caller}-${var.name}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
