
# 💻 Terraform Exercise 2 – Launch EC2 Instance with Security Group & Key Pair

This Terraform configuration demonstrates how to launch an EC2 instance on AWS using a custom key pair and security group, and then output the instance ID.

---

## 📁 Files Included

- `provider.tf` – AWS provider configuration
- `keypair.tf` – Creates an AWS key pair for SSH access
- `securityGroup.tf` – Defines a security group with specific ingress rules
- `instance.tf` – Launches an EC2 instance with key pair and security group
- `instansID.tf` – Outputs the EC2 instance ID

---

## 📜 Summary of Terraform Components

### `provider.tf`

Configures AWS region and credentials (from CLI profile, env vars, etc).

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### `keypair.tf`

Creates a new key pair from a public key file.

```hcl
resource "aws_key_pair" "vprofile" {
  key_name   = "vprofile-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
```

### `securityGroup.tf`

Allows SSH, HTTP, and custom app port (e.g. 8080).

```hcl
resource "aws_security_group" "vprofile_sg" {
  name        = "vprofile-sg"
  description = "Allow SSH, HTTP and app port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["myIP/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### `instance.tf`

Creates a t2.micro EC2 instance using the latest Ubuntu AMI.

```hcl
resource "aws_instance" "vprofile_instance" {
  ami           = data.aws_ami.amiID.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.vprofile.key_name
  vpc_security_group_ids = [aws_security_group.vprofile_sg.id]

  tags = {
    Name = "vprofile-app"
  }
}
```

### `instansID.tf`

Outputs the instance ID after deployment.

```hcl
output "instance_id" {
  value = aws_instance.vprofile_instance.id
}
```

---

## 🧾 Steps to Deploy

1. Ensure AWS credentials are configured
2. Run:

```bash
terraform init
terraform plan
terraform apply
```

3. Confirm creation, then SSH into the instance using:

```bash
ssh -i ~/.ssh/id_rsa ubuntu@<public_ip>
```

---

## 🔐 Notes

- Ensure the referenced `id_rsa.pub` file exists
- The AMI ID is dynamically retrieved via data source (`data "aws_ami"`), assumed to be included in `instance.tf` or separate file

---

## 🧠 Learning Objectives

- Understand modular `.tf` file structure
- Create and use key pairs and security groups
- Deploy a working EC2 instance
- Use Terraform `output` blocks

---

## 📚 Resources

- [AWS EC2 Terraform Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Terraform Outputs](https://developer.hashicorp.com/terraform/language/values/outputs)
