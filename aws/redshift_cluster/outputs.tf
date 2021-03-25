output "id" {
    value = "${element(concat(aws_redshift_cluster.redshift_cluster.*.id,list("")),0)}"
}

output "arn" {
    value = "${element(concat(aws_redshift_cluster.redshift_cluster.*.arn,list("")),0)}"
}

output "dns" {
    value = "${element(concat(aws_redshift_cluster.redshift_cluster.*.dns_name,list("")),0)}"
}

output "port" {
    value = "${element(concat(aws_redshift_cluster.redshift_cluster.*.port,list("")),0)}"
}

output "public_key" {
    value = "${element(concat(aws_redshift_cluster.redshift_cluster.*.cluster_public_key,list("")),0)}"
}