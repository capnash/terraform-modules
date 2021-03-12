resource "aws_ecs_cluster" "ecs_cluster" {
    name = "${upper(var.caller)}-${var.name}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
