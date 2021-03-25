resource "aws_redshift_subnet_group" "redshift_subnet_group" {
    name = "${var.caller}-${var.name}"
    description = var.description
    subnet_ids = var.subnets
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = var.description
        Environment = var.caller
        Service = var.svc
    }

    count = local.farm
}