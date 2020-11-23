resource "aws_security_group_rule" "egress_ad" {
  count = length(var.on_perm_dns_ips)

  type        = "egress"
  protocol    = "all"
  cidr_blocks = [element(values(var.on_perm_dns_ips), count.index )]
  from_port   = "0"
  to_port     = "65535"
  description = element(keys(var.on_perm_dns_ips), count.index )

  security_group_id = aws_directory_service_directory.ad.security_group_id
}