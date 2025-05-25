
# 🧪 Terraform Exercise 1 – Find AMI ID

This Terraform exercise demonstrates how to use the `data` source block to **dynamically retrieve the latest Ubuntu AMI ID** from AWS.

---

## 🎯 Objective

Use a **data source** to query AWS and output the latest AMI ID for Ubuntu 22.04 (Jammy Jellyfish) using HVM and SSD-backed volumes.

---

## 📂 Files

### `main.tf`

```hcl
data "aws_ami" "amiID" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical (official Ubuntu images)
}

output "instance_id" {
  description = "AMI ID of latest Ubuntu 22.04"
  value       = data.aws_ami.amiID.id
}
```

---

## 🧾 Steps to Run

1. Ensure you have AWS credentials configured (`~/.aws/credentials` or via environment variables)
2. Run the following commands in the terminal:

```bash
terraform init
terraform plan
terraform apply
```

3. Output will be similar to:

```hcl
Outputs:

instance_id = "ami-xxxxxxxxxxxxxxxxx"
```

---

## 🧠 Explanation

- `data "aws_ami"`: Fetches info without creating a resource
- `most_recent = true`: Ensures we get the latest AMI version
- `filters`: Limit to specific OS and virtualization type
- `owners`: Canonical’s AWS account (`099720109477`)
- `output`: Displays the AMI ID at the end of `apply`

---

## 📚 References

- [Terraform AWS AMI Data Source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)
- [Official Ubuntu AMI IDs](https://cloud-images.ubuntu.com/locator/)
