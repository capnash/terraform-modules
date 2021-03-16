output "name" {
    value = "${element(concat(aws_elasticache_subnet_group.cache_subnet_group.*.name,list("")),0)}"
}
