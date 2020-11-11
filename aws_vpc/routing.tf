resource "aws_route_table" "public" {
  vpc_id           = aws_vpc.vpc.id
  tags             = merge(var.tags, map("Name", format("%s-rt-public", var.name)))
}

resource "aws_route_table" "private" {
  vpc_id           = aws_vpc.vpc.id
  count            = length(data.aws_availability_zones.all.names)
  tags             = merge(var.tags, map("Name", format("%s-rt-private-%s", var.name, element(data.aws_availability_zones.all.names, count.index))))
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  tags                   = merge(var.tags, map("Name", format("%s-rt-default-%s", var.name, element(data.aws_availability_zones.all.names, count.index))))
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_nat_gateway" {
  count                  = var.enable_nat_gateway ? length(data.aws_availability_zones.all.names) : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.natgw.*.id, count.index)
}

# using length(data.aws_availability_zones.all.names) as count will resolve dependency issues. And the length must be the same as the target list's

resource "aws_vpc_endpoint_route_table_association" "public_s3_cidr" {
  vpc_endpoint_id = aws_vpc_endpoint.ep.id
  route_table_id  = aws_route_table.public.id
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count           = var.enable_s3_endpoint ? length(data.aws_availability_zones.all.names) : 0
  vpc_endpoint_id = aws_vpc_endpoint.ep.id
  route_table_id  = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "private_cidr" {
  count          = length(data.aws_availability_zones.all.names)
  subnet_id      = element(concat(aws_subnet.private_cidr.*.id, aws_subnet.private.*.id), count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "rds_cidr" {
  count          = length(data.aws_availability_zones.all.names)
  subnet_id      = element(concat(aws_subnet.rds_cidr.*.id, aws_subnet.rds.*.id), count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "elasticache_cidr" {
  count          = length(data.aws_availability_zones.all.names)
  subnet_id      = element(concat(aws_subnet.elasticache_cidr.*.id, aws_subnet.elasticache.*.id), count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "public_cidr" {
  count          = length(data.aws_availability_zones.all.names)
  subnet_id      = element(concat(aws_subnet.public_cidr.*.id, aws_subnet.public.*.id), count.index)
  route_table_id = aws_route_table.public.id
}

