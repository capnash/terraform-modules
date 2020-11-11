resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, map("Name", format("%s-sg-default", var.name)))

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  ingress {
    protocol  = -1
    cidr_blocks = ["10.0.0.0/8"]
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "${var.name}-sg-ssh"
  vpc_id      = aws_vpc.vpc.id
  description = "Allow SSH"
  tags        = merge(var.tags, map("Name", format("%s-sg-ssh", var.name)))

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress_ssh" {
  count = length(var.ssh_safe_ips)

  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = [element(values(var.ssh_safe_ips), count.index )]
  from_port   = "22"
  to_port     = "22"
  description = element(keys(var.ssh_safe_ips), count.index )

  security_group_id = aws_security_group.ssh_sg.id
}

# resource "aws_security_group_rule" "cidr_ssh" {
#   type        = "ingress"
#   protocol    = "tcp"
#   cidr_blocks = ["${var.cidr}"]
#   from_port   = "22"
#   to_port     = "22"
#   description = "VPC"

#   security_group_id = "${aws_security_group.ssh_sg.id}"
# }

resource "aws_security_group" "rdp_sg" {
  name        = "${var.name}-sg-rdp"
  vpc_id      = aws_vpc.vpc.id
  description = "Allow Microsofts remote desktop"
  tags        = merge(var.tags, map("Name", format("%s-sg-rdp", var.name)))

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress_rdp_tcp" {
  count = length(var.ssh_safe_ips)

  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = [element(values(var.ssh_safe_ips), count.index )]
  from_port   = "3389"
  to_port     = "3389"
  description = element(keys(var.ssh_safe_ips), count.index )

  security_group_id = aws_security_group.rdp_sg.id
}

# resource "aws_security_group_rule" "ingress_rdp_udp" {
#   count = "${length(var.ssh_safe_ips)}"

#   type        = "ingress"
#   protocol    = "udp"
#   cidr_blocks = ["${element(values(var.ssh_safe_ips), count.index )}"]
#   from_port   = "3389"
#   to_port     = "3389"
#   description = "${element(keys(var.ssh_safe_ips), count.index )}"

#   security_group_id = "${aws_security_group.rdp_sg.id}"
# }