output "name" {
    value = "${element(concat(aws_glue_catalog_database.glue_catalog_database.*.name,list("")),0)}"
}
