resource "aws_dms_replication_subnet_group" "dms_subnet_group" {
    replication_subnet_group_description = var.description
    replication_subnet_group_id = "${var.caller}-${var.subnet_group_id}"

    subnet_ids = var.subnet_ids

    tags = {
        Name = "${var.caller}-${var.subnet_group_id}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
        Description = var.description
    }

    count = local.farm
}