# ##### VPC #####
# output vpc_id {
#   value = "${aws_vpc.vpc.id}"
# }

# output vpc_cidr_block {
#   value = "${aws_vpc.vpc.cidr_block}"
# }

# ##### Subnets #####
# output "public_subnets" {
#   value = ["${concat(aws_subnet.public.*.id, aws_subnet.public_cidr.*.id)}"]
# }

# output "private_subnets" {
#   value = ["${concat(aws_subnet.private.*.id, aws_subnet.private_cidr.*.id)}"]
# }

# output "rds_subnets" {
#   value = ["${concat(aws_subnet.rds.*.id, aws_subnet.rds_cidr.*.id)}"]
# }

# output "rds_subnet_group_name" {
#   value = "${concat(aws_db_subnet_group.rds.*.name, aws_db_subnet_group.rds_cidr.*.name)}"
# }

# output "rds_subnet_group_id" {
#   value = "${concat(aws_db_subnet_group.rds.*.id, aws_db_subnet_group.rds_cidr.*.id)}"
# }

# output "rds_subnet_group_arn" {
#   value = "${concat(aws_db_subnet_group.rds.*.arn, aws_db_subnet_group.rds_cidr.*.arn)}"
# }

# output "elasticache_subnets" {
#   value = ["${concat(aws_subnet.elasticache.*.id, aws_subnet.elasticache_cidr.*.id)}"]
# }

# output "elasticache_subnet_group_name" {
#   value = "${concat(aws_elasticache_subnet_group.elasticache.*.name, aws_elasticache_subnet_group.elasticache_cidr.*.name)}"
# }

# output "elasticache_subnet_group_id" {
#   value = "${concat(aws_elasticache_subnet_group.elasticache.*.id, aws_elasticache_subnet_group.elasticache_cidr.*.id)}"
# }


# ##### Endpoints and Gateways #####
# output "igw_id" {
#   value = "${aws_internet_gateway.igw.id}"
# }

# output "nat_eips" {
#   value = ["${aws_eip.nateip.*.id}"]
# }

# output "nat_eips_public_ips" {
#   value = ["${aws_eip.nateip.*.public_ip}"]
# }

# output "natgw_ids" {
#   value = ["${aws_nat_gateway.natgw.*.id}"]
# }

# output "vpn_gateway_id" {
#   value = "${aws_vpn_gateway.vpn_gateway.id}"
# }


# ##### Routing #####
# output "public_route_table_ids" {
#   value = ["${aws_route_table.public.*.id}"]
# }

# output "private_route_table_ids" {
#   value = ["${aws_route_table.private.*.id}"]
# }

# ##### Security Groups #####
# output "ssh_sg_id" {
#   value = "${aws_security_group.ssh_sg.id}"
# }

# output "common_sg_ids" {
#   value = ["${aws_security_group.ssh_sg.id}"]
# }

# output "common_sg_names" {
#   value = ["${aws_security_group.ssh_sg.name}"]
# }

# output "rdp_sg_id" {
#   value = "${aws_security_group.rdp_sg.id}"
# }

