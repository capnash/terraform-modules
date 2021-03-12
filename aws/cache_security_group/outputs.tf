output "name" {
    value = "${element(concat(aws_elasticache_security_group.cache_security_group.*.name,list("")),0)}"
}
