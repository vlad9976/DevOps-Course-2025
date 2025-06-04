# DOC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "terra-sg" {
  name        = "terra-sg"
  description = "terra-sg"

  tags = {
    Name = "terra-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_myip" {
  security_group_id = aws_security_group.terra-sg.id
  cidr_ipv4         = "YOURIP/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.terra-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_bound" {
  security_group_id = aws_security_group.terra-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_bound_ipv6" {
  security_group_id = aws_security_group.terra-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
