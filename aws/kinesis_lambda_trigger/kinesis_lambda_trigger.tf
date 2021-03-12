resource "aws_lambda_event_source_mapping" "kinesis_lambda_event_trigger" {
  event_source_arn = "${var.kinesis_stream_arn}"
  function_name = "${var.lambda_function_arn}"
  starting_position = "LATEST"
}
