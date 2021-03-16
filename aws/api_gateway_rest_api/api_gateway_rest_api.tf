resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
    name = "${var.caller}-${var.name}"
    description = "${var.description}"
    dynamic "endpoint_configuration" {
        for_each = [for key in var.endpoint_config: {
            map = merge(local.defaults.endpoint_configuration,key)
        }]
        content {
            types = endpoint_configuration.value.map.types
            vpc_endpoint_ids = endpoint_configuration.value.map.vpc_endpoint_ids
        }
    }
    binary_media_types = "${var.binary_media_types}"
    minimum_compression_size = "${var.compression_size}"
    policy = "${var.policy}"
    api_key_source = "${var.api_key_source}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
