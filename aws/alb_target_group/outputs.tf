output "arn" {
    value = "${element(concat(aws_lb_target_group.alb_target_group.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_lb_target_group.alb_target_group.*.id,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_lb_target_group.alb_target_group.*.name,list("")),0)}"
}