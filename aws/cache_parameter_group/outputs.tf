output "id" {
    value = "${element(concat(aws_elasticache_parameter_group.cache_parameter_group.*.id,list("")),0)}"
}
