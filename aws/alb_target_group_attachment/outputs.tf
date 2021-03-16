output "id" {
    value = "${element(concat(aws_lb_target_group_attachment.alb_target_group_attachment.*.id,list("")),0)}"
}