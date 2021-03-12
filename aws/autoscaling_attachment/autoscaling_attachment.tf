resource "aws_autoscaling_attachment" "autoscaling_attachment" {
    autoscaling_group_name = var.autoscaling_group
    alb_target_group_arn = var.target_group

    count = local.farm
}
