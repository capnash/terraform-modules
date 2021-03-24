output "arn" {
    value = "${element(concat(aws_redshift_snapshot_schedule.redshift_snapshot_schedule.*.arn,list("")),0)}"
}