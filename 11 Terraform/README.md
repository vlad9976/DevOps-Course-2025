
# 🌍 Terraform for Infrastructure as Code (IaC) – README

Terraform is an open-source Infrastructure as Code (IaC) tool by HashiCorp used to provision and manage infrastructure across cloud providers.

This section focuses on core concepts, syntax, and hands-on examples of deploying infrastructure using Terraform.

---

## 🚀 Why Terraform?

- Cloud-agnostic: Works with AWS, Azure, GCP, etc.
- Declarative syntax (HCL – HashiCorp Configuration Language)
- Safe and predictable changes (terraform plan/apply)
- Manages dependencies and state

---

## 🔧 Installation

Download from: https://www.terraform.io/downloads.html

For Ubuntu:

```bash
sudo apt update
sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
terraform -version
```

---

## 📄 Terraform File Structure

```bash
project/
├── main.tf        # Main infrastructure configuration
├── variables.tf   # Input variables
├── outputs.tf     # Output variables
├── provider.tf    # Cloud provider setup (e.g., AWS)
└── terraform.tfvars # Variable values
```

---

## 📌 Basic Commands

```bash
terraform init        # Initialize working directory
terraform fmt         # Format code
terraform validate    # Validate config
terraform plan        # Show changes before applying
terraform apply       # Apply configuration
terraform destroy     # Tear down infrastructure
```

---

## 🌐 Example: AWS EC2 Deployment

### provider.tf

```hcl
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
```

### main.tf

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "MyTerraformEC2"
  }
}
```

### variables.tf

```hcl
variable "region" {
  default = "us-east-1"
}
```

---

## 📦 Best Practices

- Use modules for reusable code
- Store state remotely (S3 + DynamoDB for AWS)
- Enable version control (Git)
- Lock Terraform versions with `required_version`
- Use `terraform.tfvars` for secrets (never commit to Git)

---

## 🔐 Remote State Example (AWS)

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

## 📚 References

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Best Practices](https://developer.hashicorp.com/terraform/cli)
