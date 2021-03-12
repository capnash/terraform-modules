variable "caller" {}

variable "envname" {
    default = []
}

variable "listener" {}

variable "priority" {
    default = null
}

variable "conditions" {
    default = []
}

variable "type" {
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
        conditions = {
            host_header = null
            http_header = []
            http_request_method = null
            path_pattern = null
            query_string = []
        }
        query_string = {
            key = null
            value = ""
        }
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
