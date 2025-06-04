# Doc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.terra-sg.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "Terra-instance"
    project = "Terraform"
  }
  # Doc https://developer.hashicorp.com/terraform/language/resources/provisioners/connection
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("terra-key")
    host        = self.public_ip # get public ip of web
  }
  #Doc https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }


}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "webpublicip" {
  description = "Web public ip"
  value       = aws_instance.web.public_ip
}

# 1. terraform init
# 2. terraform fmt = format
# 3. terraform validate = validate variables
# 4. terrform plan = what will be changed
# 5. terraform apply = apply hcanges
# 6. terraform destroy = destroy all from current directory deployment