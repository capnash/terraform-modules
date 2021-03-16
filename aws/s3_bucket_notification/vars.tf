variable "bucket_id" {}
variable "sqs" {
    default = []
}
variable "sns" {
    default = []
}
variable "lambda" {
    default = []
}

locals {
    defaults = {
        sqs = {
            queue_arn = ""
            events = ""
            filter_suffix = ""
            filter_prefix = ""
        }
        sns = {
            topic_arn = ""
            events = ""
            filter_suffix = ""
            filter_prefix = ""
        }
        lambda = {
            lambda_function_arn = ""
            events = ""
            filter_suffix = ""
            filter_prefix = ""
        }
    } 
}