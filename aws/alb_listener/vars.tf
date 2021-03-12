variable "caller" {}

variable "envname" {
    default = []
}

variable "alb" {}

variable "port" {
    default = 443
}

variable "protocol" {
    default = "HTTPS"
}

variable "certificate" {
    default = null
}

variable "ssl_policy" {
    default = null
}

variable "action_type" {
    default = "forward"
}

variable "target" {
    default = null
}

variable "redirect" {
    default = []
}

variable "response" {
    default = []
}

variable "cognito" {
    default = []
}

variable "oidc" {
    default = []
}

locals {
    defaults = {
        redirect = {
            host = null
            path = null
            port = null
            protocol = null
            query = null
            status_code = "HTTP_301"
        }
        fixed_response = {
            content_type = ""
            message_body = null
            status_code = null
        }
        authenticate_cognito = {
            on_unauthenticated_request = "deny"
            scope = null
            session_cookie_name = null
            session_timeout = null
            user_pool_arn = ""
            user_pool_client_id = ""
            user_pool_domain = ""
        }
        authenticate_oidc = {
            authorization_endpoint = ""
            client_id = ""
            client_secret = ""
            issuer = ""
            on_unauthenticated_request = "deny"
            session_cookie_name = null
            session_timeout = null
            token_endpoint = ""
            user_info_endpoint = ""
        }
    }
    scale = 1
    enabled = "${contains(var.envname,"${var.caller}")==true ? 1 : 0}"
    farm = "${local.scale * local.enabled}"
}
