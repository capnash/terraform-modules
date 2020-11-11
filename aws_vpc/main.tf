data "aws_availability_zones" "all" {}

data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

