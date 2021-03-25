resource "aws_redshift_snapshot_schedule_association" "redshift_snapshot_schedule_association" {
    cluster_identifier = var.cluster
    scheduler_identifier = var.schedule

    count = local.farm
}