data "aws_availability_zones" "all" {}

data "aws_vpc_endpoint_service" "s3" {
  service      = "s3"
  service_type = "Gateway"
}

data "aws_vpc_endpoint_service" "dynamodb" {
  service       = "dynamodb"	  
  service_type  = "Gateway"
}