resource "aws_api_gateway_stage" "api_gateway_stage" {
    rest_api_id = "${var.rest_api}"
    stage_name = "${var.name}"
    deployment_id = "${var.deployment}"
    dynamic "access_log_settings" {
        for_each = [for key in var.log_settings: {
            map = merge(local.defaults.access_log_settings,key)
        }]
        content {
            destination_arn = access_log_settings.value.map.destination_arn
            format = access_log_settings.value.map.format
        }
    }
    cache_cluster_enabled = "${var.cache_enabled}"
    cache_cluster_size = "${var.cache_cluster_size}"
    client_certificate_id = "${var.client_cert}"
    description = "${var.description}"
    document_version = "${var.doc_version}"
    variables = "${var.env_vars}"
    xray_tracing_enabled = "${var.xray_trace}"
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
