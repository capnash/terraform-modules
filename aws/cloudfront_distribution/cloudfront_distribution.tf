resource "aws_cloudfront_distribution" "cloudfront_distribution" {
    aliases = "${var.aliases}"
    comment = "${var.caller} ${var.description}"
    dynamic "custom_error_response" {
        for_each = [for key in var.error_msg: {
            error_caching_min_ttl = key.error_caching_min_ttl
            error_code = key.error_code
            response_code = key.response_code
            response_page_path = key.response_page_path
        }]
        content {
            error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
            error_code = custome_error_response.value.error_code
            response_code = custom_error_response.value.response_code
            response_page_path = custom_error_response.value.response_page_path
        }
    }
    default_cache_behavior {
        allowed_methods = "${local.merged.default_cache_behavior.allowed_methods}"
        cached_methods = "${local.merged.default_cache_behavior.cached_methods}"
        compress = "${local.merged.default_cache_behavior.compress}"
        default_ttl = "${local.merged.default_cache_behavior.default_ttl}"
        field_level_encryption_id = "${local.merged.default_cache_behavior.field_level_encryption_id}"
        forwarded_values {
            cookies {
                forward = "${local.merged_forward.cookies.forward}"
                whitelisted_names = "${local.merged_forward.cookies.whitelisted_names}"
            }
            headers = "${local.merged_cache.forwarded_values.headers}"
            query_string = "${local.merged_cache.forwarded_values.query_string}"
        }
        max_ttl = "${local.merged.default_cache_behavior.max_ttl}"
        min_ttl = "${local.merged.default_cache_behavior.min_ttl}"
        smooth_streaming = "${local.merged.default_cache_behavior.smooth_streaming}"
        target_origin_id = "${local.merged.default_cache_behavior.target_origin_id}"
        viewer_protocol_policy = "${local.merged.default_cache_behavior.viewer_protocol_policy}"
        dynamic "lambda_function_association" {
            for_each = [for key in local.merged.default_cache_behavior.lambda_function_association: {
                map = merge(local.defaults.lambda_function_association,key)
            }]
            content {
                event_type = lambda_function_association.value.map.event_type
                lambda_arn = lambda_function_association.value.map.lambda_arn
                include_body = lambda_function_association.value.map.include_body
            }
        }
    }
    default_root_object = "${var.default_root_object}"
    enabled = "${var.enabled}"
    is_ipv6_enabled = "${var.ipv6}"
    http_version = "${var.http_version}"
    dynamic "logging_config" {
        for_each = [for key in var.logging_config: {
            map = merge(local.defaults.logging_config,key)
        }]
        content {
            bucket = logging_config.value.map.bucket
            include_cookies = logging_config.value.map.include_cookies
            prefix = logging_config.value.map.prefix
        }
    }
    dynamic "ordered_cache_behavior" {
        for_each = [for key in var.ordered_cache_behavior: {
            map = merge(local.defaults.default_cache_behavior,key)
            map_forward = merge(local.defaults.default_cache_behavior.forwarded_values,key.forwarded_values)
            map_cookie = merge(local.defaults.default_cache_behavior.forwarded_values.cookies,key.forwarded_values.cookies)
        }]
        content {
            allowed_methods = ordered_cache_behavior.value.map.allowed_methods
            cached_methods = ordered_cache_behavior.value.map.cached_methods
            compress = ordered_cache_behavior.value.map.compress
            default_ttl = ordered_cache_behavior.value.map.default_ttl
            field_level_encryption_id = ordered_cache_behavior.value.map.field_level_encryption_id
            forwarded_values {
                cookies {
                    forward = ordered_cache_behavior.value.map_cookie.forward
                    whitelisted_names = ordered_cache_behavior.value.map_cookie.whitelisted_names
                }
                headers = ordered_cache_behavior.value.map_forward.headers
                query_string = ordered_cache_behavior.value.map_forward.query_string
            }
            max_ttl = ordered_cache_behavior.value.map.max_ttl
            min_ttl = ordered_cache_behavior.value.map.min_ttl
            path_pattern = ordered_cache_behavior.value.map.path_pattern
            smooth_streaming = ordered_cache_behavior.value.map.smooth_streaming
            target_origin_id = ordered_cache_behavior.value.map.target_origin_id
            viewer_protocol_policy = ordered_cache_behavior.value.map.viewer_protocol_policy
            dynamic "lambda_function_association" {
                for_each = [for i in ordered_cache_behavior.value.map.lambda_function_association: {
                    lambd = merge(local.defaults.lambda_function_association,i)
                }]
                content {
                    event_type = lambda_function_association.value.lambd.event_type
                    lambda_arn = lambda_function_association.value.lambd.lambda_arn
                    include_body = lambda_function_association.value.lambd.include_body
                }
            }
        }
    }
    dynamic "origin" {
        for_each = [for key in var.origins: {
            map = merge(local.defaults.origin,key)
        }]
        content {
            origin_id = origin.value.map.origin_id
            origin_path = origin.value.map.origin_path
            domain_name = origin.value.map.domain_name
            dynamic "custom_header" {
                for_each = origin.value.map.custom_header
                content {
                    name = custom_header.value.name
                    value = custom_header.value.value
                }
            }
            dynamic "custom_origin_config" {
                for_each = [for i in origin.value.map.custom_origin_config: {
                    endp = merge(local.defaults.custom_origin_config,i)
                }]
                content {
                    http_port = custom_origin_config.value.endp.http_port
                    https_port = custom_origin_config.value.endp.https_port
                    origin_protocol_policy = custom_origin_config.value.endp.origin_protocol_policy
                    origin_ssl_protocols = custom_origin_config.value.endp.origin_ssl_protocols
                    origin_keepalive_timeout = custom_origin_config.value.endp.origin_keepalive_timeout
                    origin_read_timeout = custom_origin_config.value.endp.origin_read_timeout
                }
            }
            dynamic "s3_origin_config" {
                for_each = [for n in origin.value.map.s3_origin_config: {
                    s3 = merge(local.defaults.s3_origin_config,n)
                }]
                content {
                    origin_access_identity = custom_origin_config.value.endp.origin_access_identity
                }
            }
        }
    }
    dynamic "origin_group" {
        for_each = [for key in var.origin_groups: {
            map = merge(local.defaults.origin_group,key)
            other = []
        }]
        content {
            origin_id = origin_group.value.map.origin_id
            failover_criteria {
                status_codes = origin_group.value.map.failover_criteria.status_codes
            }
            dynamic "member" {
                for_each = [for i in origin_group.value.map.member: {
                    mmbr = merge(local.defaults.member,i)
                }]
                content {
                    origin_id = member.value.mmbr.origin_id
                }
            }
            dynamic "member" {
                for_each = origin_group.value.other
                content {
                    origin_id = ""
                }
            }
        }
    }
    price_class = "${var.price_class}"
    restrictions {
        geo_restriction {
            restriction_type = "${var.restriction}"
            locations = "${var.restriction_locations}"
        }
    }
    viewer_certificate {
        acm_certificate_arn = "${local.merged.viewer_certificate.acm_certificate_arn}"
        cloudfront_default_certificate = "${local.merged.viewer_certificate.cloudfront_default_certificate}"
        iam_certificate_id = "${local.merged.viewer_certificate.iam_certificate_id}"
        minimum_protocol_version = "${local.merged.viewer_certificate.minimum_protocol_version}"
        ssl_support_method = "${local.merged.viewer_certificate.ssl_support_method}"
    }
    web_acl_id = "${var.waf}"
    retain_on_delete = "${var.retain}"
    wait_for_deployment = "${var.wait_for_deploy}"
    tags = {
        Name = "${var.caller}-${var.name}"
        Description = "${var.description}"
        Environment = "${var.caller}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
