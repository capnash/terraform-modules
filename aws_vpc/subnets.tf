resource "aws_subnet" "public_cidr" {
  count             = length(data.aws_availability_zones.all.names)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.public_subnets_cidr, var.logical_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)
  tags              = merge(var.tags, var.public_subnet_tags, map("Name", format("%s-subnet-public-%s", var.name, substr(element(data.aws_availability_zones.all.names, count.index), -2,-1) )))

  map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_subnet" "private_cidr" {
  count             = length(data.aws_availability_zones.all.names)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.private_subnets_cidr, var.logical_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)
  tags              = merge(var.tags, var.private_subnet_tags, map("Name", format("%s-subnet-private-%s", var.name, substr(element(data.aws_availability_zones.all.names, count.index), -2,-1) )))
}

resource "aws_subnet" "rds_cidr" {
  count             = length(data.aws_availability_zones.all.names)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.rds_subnets_cidr, var.logical_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)
  tags              = merge(var.tags, var.rds_subnet_tags, map("Name", format("%s-subnet-rds-%s", var.name, substr(element(data.aws_availability_zones.all.names, count.index), -2,-1) )))
}

resource "aws_subnet" "elasticache_cidr" {
  count             = length(data.aws_availability_zones.all.names)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.elasticache_subnets_cidr, var.logical_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.all.names, count.index)
  tags              = merge(var.tags, var.elasticache_subnet_tags, map("Name", format("%s-subnet-elasticache-%s", var.name, substr(element(data.aws_availability_zones.all.names, count.index), -2,-1) )))
}

resource "aws_db_subnet_group" "rds_cidr" {
  name        = "${var.name}-rds-subnet-group"
  description = "Database subnet groups for ${var.name}"
  subnet_ids  = aws_subnet.rds_cidr.*.id
  tags        = merge(var.tags, map("Name", format("%s-rds-subnet-group", var.name)))
}

resource "aws_elasticache_subnet_group" "elasticache_cidr" {    
  name        = "${var.name}-elasticache-subnet-group"
  description = "elasticache subnet groups for ${var.name}"  
  subnet_ids  = aws_subnet.elasticache_cidr.*.id
}
