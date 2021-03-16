resource "aws_dynamodb_table" "dynamodb_table" {
    name                = "${var.caller}-${var.name}"
    billing_mode        = "${var.billing_mode}"
    read_capacity       = "${var.read_capacity}"
    write_capacity      = "${var.write_capacity}"
    hash_key            = "${var.hash_key}"
    range_key           = "${var.range_key}"

    dynamic "attribute" {
      for_each = var.attributes
      content {
        name = attribute.value["name"]
        type = attribute.value["type"]
      }
    }

    dynamic "ttl" {
        for_each = [for key in var.ttl: {
            map = merge(local.defaults.ttl,key)
        }]
        content {
            attribute_name = ttl.value.map.attribute_name
            enabled = ttl.value.map.enabled
        }
    }

    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }
    lifecycle {
        ignore_changes = [read_capacity,write_capacity]
  }

    count = "${local.farm}"
}
