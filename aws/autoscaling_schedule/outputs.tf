output "arn" {
    value = "${element(concat(aws_autoscaling_schedule.autoscaling_schedule.*.arn,list("")),0)}"
}
