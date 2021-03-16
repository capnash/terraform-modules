resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = "${var.alb}"
    port = "${var.port}"
    protocol = "${var.protocol}"
    certificate_arn = "${var.certificate}"
    ssl_policy = "${var.ssl_policy}"
    default_action {
        type = "${var.action_type}"
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
