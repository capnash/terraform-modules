output "arn" {
    value = "${element(concat(aws_lb_listener_rule.alb_listener_rule.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_lb_listener_rule.alb_listener_rule.*.id,list("")),0)}"
}
