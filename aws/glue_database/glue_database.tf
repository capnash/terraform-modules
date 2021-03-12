resource "aws_glue_catalog_database" "glue_catalog_database" {
  name = "${lower(var.caller)}_${lower(var.name)}"
}