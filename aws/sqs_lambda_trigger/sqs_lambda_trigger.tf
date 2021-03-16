resource "aws_lambda_event_source_mapping" "sqs_lambda_event_trigger" {
  event_source_arn = "${var.queue_arn}"
  function_name = "${var.lambda_function_arn}"
}
