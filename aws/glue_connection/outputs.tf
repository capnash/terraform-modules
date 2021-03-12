output "id" {
    value = "${element(concat(aws_glue_connection.glue_redshift_vpc_connection.*.id,list("")),0)}"
}

output "name" {
    value = "${element(concat(aws_glue_connection.glue_redshift_vpc_connection.*.name,list("")),0)}"
}