##### VPC #####
output vpc_id {
  value = aws_vpc.vpc.id
}

output vpc_cidr_block {
  value = aws_vpc.vpc.cidr_block
}

output vpc_enable_classiclink {
  value = aws_vpc.vpc.enable_classiclink
}

output vpc_main_route_table_id {
  value = aws_vpc.vpc.main_route_table_id
}

output vpc_default_network_acl_id {
  value = aws_vpc.vpc.default_network_acl_id
}

output vpc_default_security_group_id {
  value = aws_vpc.vpc.default_security_group_id 
}

output vpc_default_route_table_id {
  value = aws_vpc.vpc.default_route_table_id 
}

##### Subnets #####
output "public_subnets" {
  value = aws_subnet.public_cidr.*.id
}

output "private_subnets" {
  value = aws_subnet.private_cidr.*.id
}

output "rds_subnets" {
  value = aws_subnet.rds_cidr.*.id
}

output "elasticache_subnets" {
  value = aws_subnet.elasticache_cidr.*.id
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_cidr.*.name
}

output "rds_subnet_group_id" {
  value = aws_db_subnet_group.rds_cidr.*.id
}

output "rds_subnet_group_arn" {
  value = aws_db_subnet_group.rds_cidr.*.arn
}

output "elasticache_subnet_group_name" {
  value = aws_elasticache_subnet_group.elasticache_cidr.*.name
}

output "elasticache_subnet_group_id" {
  value = aws_elasticache_subnet_group.elasticache_cidr.*.id
}


##### Endpoints and Gateways #####
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "s3_endpoint_id" {
  value = aws_vpc_endpoint.ep.id
}

output "s3_endpoint_arn" {
  value = aws_vpc_endpoint.ep.arn
}


output "nat_eips" {
  value = aws_eip.nateip.*.id
}

output "nat_eips_public_ips" {
  value = aws_eip.nateip.*.public_ip
}

output "natgw_ids" {
  value = aws_nat_gateway.natgw.*.id
}

output "vpn_gateway_id" {
  value = aws_vpn_gateway.vpn_gateway.id
}


##### Routing #####
output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "private_route_table_id" {
  value = aws_default_route_table.default.id
}

# ##### Security Groups #####
output "ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "common_sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "common_sg_name" {
  value = aws_security_group.ssh_sg.name
}

output "rdp_sg_id" {
  value = aws_security_group.rdp_sg.id
}

