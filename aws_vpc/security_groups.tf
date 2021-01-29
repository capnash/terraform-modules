resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, map("Name", format("%s-sg-default", var.name)))

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

#remove this when FSX connection is no longer required XI.
  ingress {
    description = "This is tcp port for the FSX SMB connection"
    protocol    = "tcp"
    from_port   = 445
    to_port     = 445
    cidr_blocks = ["10.0.0.0/8"]
  }

#remove this when FSX connection is no longer required for XI.
  ingress {
    description = "This is tcp port for the FSX Windows connection"
    protocol    = "tcp"
    from_port   = 5985
    to_port     = 5985
    cidr_blocks = ["10.0.0.0/8"]
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
