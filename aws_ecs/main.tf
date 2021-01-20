data "aws_availability_zones" "all" {}

data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

# data "template_file" "user_data" {
#   template = file("./files/user_data.sh")

#   vars = 
# }

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