resource "aws_redshift_snapshot_schedule" "redshift_snapshot_schedule" {
    identifier = "${var.caller}-${var.name}"
    description = var.description
    definitions = var.schedules
    force_destroy = var.force_destroy
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = var.description
        Environment = var.caller
        Service = var.svc
    }

    count = local.farm
}