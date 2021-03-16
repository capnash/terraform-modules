output "arn" {
    value = "${element(concat(aws_lb_listener.alb_listener.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_lb_listener.alb_listener.*.id,list("")),0)}"
}