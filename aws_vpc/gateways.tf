resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, map("Name", format("%s-vpngw", var.name)))
}