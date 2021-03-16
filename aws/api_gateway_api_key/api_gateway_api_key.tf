resource "aws_api_gateway_api_key" "api_gateway_api_key" {
    name = "${var.caller}-${var.name}"
    description = "${var.description}"
    enabled = "${var.enabled}"
    value = "${var.key}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
