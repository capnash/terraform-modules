output "id" {
    value = "${element(concat(aws_ecs_capacity_provider.ecs_capacity_provider.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_ecs_capacity_provider.ecs_capacity_provider.*.arn,list("")),0)}"
}