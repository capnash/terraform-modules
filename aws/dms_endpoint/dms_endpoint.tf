resource "aws_dms_endpoint" "dms_endpoint" {
    database_name = var.database_name
    endpoint_id = "${var.caller}-${var.endpoint_id}"
    endpoint_type = var.endpoint_type
    engine_name = var.engine_name
    kms_key_arn = var.kms_key_arn
    password = var.password
    port = var.port
    server_name = var.server_name
    ssl_mode = var.ssl_mode
    username = var.username

    tags = {
        Name = "${upper(var.caller)}-${var.endpoint_id}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
        Description = var.description
    }

    count = local.farm
}