data "aws_availability_zones" "all" {}

data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

data "template_file" "user_data" {
  template = file("./files/user_data.sh")

  vars = {
    ecs_config        = var.ecs_config
    ecs_logging       = var.ecs_logging
    cluster_name      = aws_ecs_cluster.cluster.name
    custom_userdata   = var.custom_userdata
    cloudwatch_prefix = "${var.environment}-aws-ecs"
    time_zone_path    = var.time_zone_path
  }
}

data "archive_file" "slack_notifications" {
  type        = "zip"
  source_file = "./files/slack_notification/snsToSlack.js"
  output_path = "./files/slack_notification/snsToSlack.js.zip"
}

data "archive_file" "ecs_lifecycle_function" {
  type        = "zip"
  source_file = "./files/ecs_lifecycle_function/index.py"
  output_path = "./files/ecs_lifecycle_function/index.py.zip"
}