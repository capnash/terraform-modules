resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, map("Name", format("%s-igw", var.name)))
}

resource "aws_vpc_endpoint" "ep" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = data.aws_vpc_endpoint_service.s3.service_name
  vpc_endpoint_type = "Gateway"
  tags              = merge(var.tags, map("Name", format("%s-ep", var.name)))
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = data.aws_vpc_endpoint_service.dynamodb.service_name
  vpc_endpoint_type = "Gateway"
  tags              = merge(var.tags, map("Name", format("%s-dynamodb-ep", var.name)))
}

resource "aws_eip" "nateip" {
  vpc   = true
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(data.aws_availability_zones.all.names)) : 0
  tags  = merge(var.tags, map("Name", format("%s-nateip", var.name)))
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = element(aws_eip.nateip.*.id, (var.single_nat_gateway ? 0 : count.index))
  subnet_id     = element(aws_subnet.public_cidr.*.id, (var.single_nat_gateway ? 0 : count.index))
  count         = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(data.aws_availability_zones.all.names)) : 0
  tags          = merge(var.tags, map("Name", format("%s-natgw", var.name)))

  depends_on    = [aws_internet_gateway.igw]
}