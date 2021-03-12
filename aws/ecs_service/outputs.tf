output "id" {
    value = "${element(concat(aws_ecs_service.ecs_service.*.id,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_ecs_service.ecs_service.*.name,list("")),0)}"
}