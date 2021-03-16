output "arn" {
    value = "${element(concat(aws_lb.alb.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_lb.alb.*.id,list("")),0)}"
}

output "dns" {
    value = "${element(concat(aws_lb.alb.*.dns_name,list("")),0)}"
}

output "zone" {
    value = "${element(concat(aws_lb.alb.*.zone_id,list("")),0)}"
}
