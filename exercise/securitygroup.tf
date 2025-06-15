resource "aws_security_group" "aws-sg" {
  name        = "aws-sg"
  description = "Security group for AWS instance"
  tags = {
    Name = "aws-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.aws-sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.aws-sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.aws-sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0" # semantically equivalent to all ports
}

