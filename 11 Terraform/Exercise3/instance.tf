# Doc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = "t3.micro"
  key_name               = "terra-key"
  vpc_security_group_ids = [aws_security_group.terra-sg.id]
  availability_zone      = "us-east-1a"

  tags = {
    Name    = "Terra-instance"
    project = "Terraform"
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

# 1. terraform init
# 2. terraform fmt
# 3. terraform validate
# 4. terrform plan
# 5. terraform apply