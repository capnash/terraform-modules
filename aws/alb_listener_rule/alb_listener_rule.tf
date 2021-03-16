resource "aws_lb_listener_rule" "alb_listener_rule" {
    listener_arn = "${var.listener}"
    priority = "${var.priority}"
    dynamic "condition" {
        for_each = [for key in var.conditions: {
            map = merge(local.defaults.conditions,key)
        }]
        content {
            dynamic "host_header" {
                for_each = condition.value.map.host_header == null ? [] : list(condition.value.map.host_header)
                content {
                    values = host_header.value
                }
            }
            dynamic "http_header" {
                for_each = [for http in condition.value.map.http_header: {
                    heads = merge(local.defaults.http_header,http)
                }]
                content {
                    http_header_name = http_header.value.heads.name
                    values = http_header.value.heads.values
                }
            }
            dynamic "http_request_method" {
                for_each = condition.value.map.http_request_method == null ? [] : list(condition.value.map.http_request_method)
                content {
                    values = http_request_method.value
                }
            }
            dynamic "path_pattern" {
                for_each = condition.value.map.path_pattern == null ? [] : list(condition.value.map.path_pattern)
                content {
                    values = path_pattern.value
                }
            }
            dynamic "query_string" {
                for_each = [for query in condition.value.map.query_string: {
                    queues = merge(local.defaults.query_string,query)
                }]
                content {
                    key = query_string.value.queues.key
                    value = query_string.value.queues.value
                }
            }
        }
    }
    action {
        type = "${var.type}"
        target_group_arn = "${var.target}"
        dynamic "redirect" {
            for_each = [for key in var.redirect: {
                map = merge(local.defaults.redirect,key)
            }]
            content {
                host = redirect.value.map.host
                path = redirect.value.map.path
                port = redirect.value.map.port
                protocol = redirect.value.map.protocol
                query = redirect.value.map.query
                status_code = redirect.value.map.status_code
            }
        }
        dynamic "fixed_response" {
            for_each = [for key in var.response: {
                map = merge(local.defaults.fixed_response,key)
            }]
            content {
                content_type = fixed_response.value.map.content_type
                message_body = fixed_response.value.map.message_body
                status_code = fixed_response.value.map.status_code
            }
        }
        dynamic "authenticate_cognito" {
            for_each = [for key in var.cognito: {
                map = merge(local.defaults.authenticate_cognito,key)
            }]
            content {
                on_unauthenticated_request = authenticate_cognito.value.map.on_unauthenticated_request
                scope = authenticate_cognito.value.map.scope
                session_cookie_name = authenticate_cognito.value.map.session_cookie_name
                session_timeout = authenticate_cognito.value.map.session_timeout
                user_pool_arn = authenticate_cognito.value.map.user_pool_arn
                user_pool_client_id = authenticate_cognito.value.map.user_pool_client_id
                user_pool_domain = authenticate_cognito.value.map.user_pool_domain
            }
        }
        dynamic "authenticate_oidc" {
            for_each = [for key in var.oidc: {
                map = merge(local.defaults.authenticate_oidc,key)
            }]
            content {
                authorization_endpoint = authenticate_oidc.value.map.authorization_endpoint
                client_id = authenticate_oidc.value.map.client_id
                client_secret = authenticate_oidc.value.map.client_secret
                issuer = authenticate_oidc.value.map.issuer
                on_unauthenticated_request = authenticate_oidc.value.map.on_unauthenticated_request
                session_cookie_name = authenticate_oidc.value.map.session_cookie_name
                session_timeout = authenticate_oidc.value.map.session_timeout
                token_endpoint = authenticate_oidc.value.map.token_endpoint
                user_info_endpoint = authenticate_oidc.value.map.user_info_endpoint
            }
        }
    }

    count = "${local.farm}"
}
