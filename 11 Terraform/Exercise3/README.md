
# 🧪 Terraform Exercise 3 – Using Variables for Dynamic Configuration

This exercise builds on the previous EC2 setup by introducing **variables** to make the Terraform configuration more flexible and reusable.

---

## 🎯 Objective

Deploy an EC2 instance on AWS with:
- Custom instance type
- Custom key pair
- Parameterized AMI ID
- Custom security group name
- All configuration values injected via `vars.tf`

---

## 📁 Files

- `provider.tf` – AWS provider config
- `vars.tf` – Declares all input variables
- `keypair.tf` – Uses variable to define key pair
- `securityGroup.tf` – Uses variable for SG name and rules
- `instance.tf` – Uses variables for AMI, instance type, and key
- `instansID.tf` – Outputs the instance ID

---

## 📄 Example: `vars.tf`

```hcl
variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "vprofile-key"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "sg_name" {
  default = "vprofile-sg"
}
```

---

## 🔧 Sample Variable Usage

### `keypair.tf`

```hcl
resource "aws_key_pair" "vprofile" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}
```

### `securityGroup.tf`

```hcl
resource "aws_security_group" "vprofile_sg" {
  name        = var.sg_name
  description = "Allow SSH & HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

```hcl
resource "aws_instance" "vprofile_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.vprofile.key_name
  vpc_security_group_ids      = [aws_security_group.vprofile_sg.id]

  tags = {
    Name = "vprofile-app"
  }
}
```

---

## 🧾 Steps to Run

1. Customize variable values in `vars.tf` or use `terraform.tfvars`
2. Initialize and apply:

```bash
terraform init
terraform plan
terraform apply
```

3. Access the EC2 instance via SSH:

```bash
ssh -i ~/.ssh/id_rsa ubuntu@<public_ip>
```

---

## 📚 Good Practices

- Use `vars.tf` to document all configurable inputs
- Keep secret values (e.g. private keys) out of Git and use `.tfvars`
- Use `terraform plan -var-file="custom.tfvars"` for overrides

---

## 📌 Output Example

```hcl
Outputs:

instance_id = "i-0abcexample123"
```

---

## 📚 References

- [Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)
- [AWS EC2 Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
