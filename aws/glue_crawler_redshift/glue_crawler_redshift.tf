resource "aws_glue_crawler" "glue_crawler_redshift" {
    name = "${upper(var.caller)}_${var.name}"
    database_name = var.glue_database_name
    role = var.role_arn

    jdbc_target {
        connection_name = var.redshift_connection_name
        path = "${var.redshift_database}/${var.redshift_schema}/%"
    }

    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }
}
