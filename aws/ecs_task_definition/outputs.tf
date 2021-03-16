output "arn" {
    value = "${element(concat(aws_ecs_task_definition.ecs_task_definition.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_ecs_task_definition.ecs_task_definition.*.family,list("")),0)}"
}