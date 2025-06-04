# 🧪 Terraform Exercise 6 – Remote Backend with S3

This exercise demonstrates how to use a remote backend (S3) to manage Terraform state, while deploying a fully provisioned EC2 instance running a basic web application.

---

## 🎯 Objective

* Store Terraform state file remotely using AWS S3
* Deploy an EC2 instance with a web server
* Use dynamic variables for flexibility
* Output instance information

---

## 📁 Files Included

| File               | Description                                 |
| ------------------ | ------------------------------------------- |
| `provider.tf`      | AWS provider configuration                  |
| `backend.tf`       | Remote backend (S3) configuration           |
| `vars.tf`          | Input variables for dynamic deployment      |
| `keypair.tf`       | Key pair configuration                      |
| `securityGroup.tf` | Security group with HTTP/SSH rules          |
| `instance.tf`      | EC2 instance definition with provisioning   |
| `web.sh`           | Shell script to install Apache & setup page |
| `instansID.tf`     | Output block for instance ID                |
| `public_ip.txt`    | Used for storing the instance public IP     |

---

## ⚙️ Remote Backend – S3 Configuration (backend.tf)

```hcl
terraform {
  backend "s3" {
    bucket = "your-s3-bucket-name"
    key    = "terraform/state/terraform.tfstate"
    region = "us-east-1"
  }
}
```

* Replace `your-s3-bucket-name` with your actual S3 bucket.

---

## 💻 EC2 Instance Provisioning (instance.tf + web.sh)

### Highlights:

* Uses AMI ID and instance type from `vars.tf`
* Installs Apache using `web.sh`
* Attaches security group and keypair

### Example Provisioner:

```hcl
provisioner "file" {
  source      = "web.sh"
  destination = "/tmp/web.sh"
}

provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/web.sh",
    "sudo /tmp/web.sh"
  ]
}
```

### Shell Script Example (web.sh):

```bash
#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Terraform Web Server</h1>" | sudo tee /var/www/html/index.html
```

---

## 🔐 Security Group (securityGroup.tf)

```hcl
resource "aws_security_group" "terra-sg" {
  name        = var.sg_name
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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

---

## 📦 Outputs (instansID.tf)

```hcl
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}
```

---

## 📄 Usage Steps

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate Configuration

```bash
terraform validate
```

### 3. Plan the Deployment

```bash
terraform plan
```

### 4. Apply the Deployment

```bash
terraform apply -auto-approve
```

---

## 🧼 Cleanup

```bash
terraform destroy -auto-approve
```

---

## 🧠 Notes

* The use of remote backend ensures state management across teams
* Store `web.sh` in same directory to provision Apache during instance setup
* S3 backend allows versioning, locking, and collaboration
