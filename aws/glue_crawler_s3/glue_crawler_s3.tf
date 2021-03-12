resource "aws_glue_crawler" "glue_crawler_s3" {
    name = "${upper(var.caller)}_${var.name}"
    database_name = var.glue_database_name
    role = var.role_arn

    s3_target {
        path = var.s3_path
    }

    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }
}
