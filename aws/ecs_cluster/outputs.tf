output "arn" {
    value = "${element(concat(aws_ecs_cluster.ecs_cluster.*.arn,list("")),0)}"
}

output "id" {
    value = "${element(concat(aws_ecs_cluster.ecs_cluster.*.id,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_ecs_cluster.ecs_cluster.*.name,list("")),0)}"
}