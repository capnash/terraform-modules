resource "aws_glue_job" "glue_job" {
    name = "${upper(var.caller)}_${var.name}"
    role_arn = var.role_arn
    glue_version = "1.0"

    connections = var.connections

    worker_type = "G.1X"
    number_of_workers = 4

    default_arguments = {
        "--extra-py-files" = var.s3_python_lib_location
        "--TempDir" = var.s3_tmp_dir
        "--extra-files" = var.s3_config_file_location
        "--ENV" = var.caller
        "--job-bookmark-option" = "job-bookmark-enable"
    }

    command {
        script_location = var.script_location
        python_version = 3
    }

    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }
}