output "id" {
    value = "${element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.domain_id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.arn,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.domain_name,list("")),0)}"
}

output "endpoint" {
    value = "${element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.endpoint,list("")),0)}"
}

output "kibana" {
    value = "${element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.kibana_endpoint,list("")),0)}"
}
