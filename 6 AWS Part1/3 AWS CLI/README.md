
# 💻 AWS CLI (Command Line Interface)

The AWS CLI is a unified tool to manage AWS services from the terminal. It enables you to automate resource management and integrate AWS tasks into your shell scripts or CI/CD pipelines.

---

## 🧰 Installation

### ✅ Linux / macOS

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### ✅ Windows
- Download the installer from: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html

---

## 🔐 Configure the CLI

```bash
aws configure
```

You will be prompted to enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., `us-east-1`)
- Output format (e.g., `json`, `table`, `text`)

---

## 📦 Useful AWS CLI Commands

### 🔍 Identity & Access
```bash
aws sts get-caller-identity              # Show current IAM identity
aws iam list-users                       # List all IAM users
```

### 🖥️ EC2
```bash
aws ec2 describe-instances               # List all EC2 instances
aws ec2 start-instances --instance-ids i-1234567890abcdef0
aws ec2 stop-instances --instance-ids i-1234567890abcdef0
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

### ☁️ S3
```bash
aws s3 ls                                # List all S3 buckets
aws s3 mb s3://mybucket                  # Make new bucket
aws s3 cp file.txt s3://mybucket/        # Upload file to bucket
aws s3 sync ./data s3://mybucket/data    # Sync folder to bucket
aws s3 rm s3://mybucket/file.txt         # Delete file
```

### 📍 Regions & AZs
```bash
aws ec2 describe-regions --output table
aws ec2 describe-availability-zones --region us-east-1
```

### 🛡️ Security Groups
```bash
aws ec2 describe-security-groups
```

### 🪪 Key Pairs
```bash
aws ec2 create-key-pair --key-name mykey --query 'KeyMaterial' --output text > mykey.pem
chmod 400 mykey.pem
```

### 📜 AMIs
```bash
aws ec2 describe-images --owners amazon --query 'Images[*].[ImageId,Name]' --output table
```

---

## 📂 CLI Output Formats

| Format | Description |
|--------|-------------|
| `json` | Structured output (default) |
| `text` | Raw text |
| `table`| Readable column format |

Example:
```bash
aws ec2 describe-instances --output table
```

---

## 🧪 Test CLI Connection

```bash
aws s3 ls                 # Should list buckets if permissions are correct
aws ec2 describe-instances --output table
```

---

## 📎 Resources

- [AWS CLI Docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [AWS CLI GitHub](https://github.com/aws/aws-cli)
- [Cheat Sheet](https://github.com/realpython/python-guide/blob/master/docs/scenarios/awscli.md)

