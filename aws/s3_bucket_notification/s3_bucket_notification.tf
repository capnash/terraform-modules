resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = var.bucket_id

    dynamic "queue" {
        for_each = [for key in var.sqs: {
            map = merge(local.defaults.sqs, key)
        }]
        content {
            queue_arn = queue.value.map.queue_arn
            events = queue.value.map.events
            filter_prefix = queue.value.map.filter_prefix
            filter_suffix = queue.value.map.filter_suffix
        }
    }

    dynamic "lambda_function" {
        for_each = [for key in var.lambda: {
            map = merge(local.defaults.lambda, key)
        }]
        content {
            lambda_function_arn = lambda_function.value.map.lambda_function_arn
            events = lambda_function.value.map.events
            filter_prefix = lambda_function.value.map.filter_prefix
            filter_suffix = lambda_function.value.map.filter_suffix
        }
    }

    dynamic "topic" {
        for_each = [for key in var.sns: {
            map = merge(local.defaults.sns, key)
        }]
        content {
            topic_arn = topic.value.map.topic_arn
            events = topic.value.map.events
            filter_prefix = topic.value.map.filter_prefix
            filter_suffix = topic.value.map.filter_suffix
        }
    }
} 
