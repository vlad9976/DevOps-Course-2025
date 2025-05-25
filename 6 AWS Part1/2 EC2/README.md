
# 🖥️ AWS EC2 (Elastic Compute Cloud)

This section provides an overview of **Amazon EC2**, AWS's Infrastructure-as-a-Service (IaaS) that allows you to run virtual servers (instances) in the cloud.

---

## ⚙️ What is EC2?

**Amazon EC2** provides resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers.

### ✅ Key Features:
- Launch virtual machines (instances) with desired OS and specs
- Scale capacity up or down within minutes
- Pay only for what you use (on-demand, reserved, spot)

---

## 📦 EC2 Components

| Component       | Description                                      |
|------------------|--------------------------------------------------|
| Instance         | Virtual server you run in EC2                    |
| AMI              | Amazon Machine Image (template for instance)     |
| Instance Type    | Defines compute resources (vCPU, RAM, etc.)      |
| Key Pair         | SSH access to your instance                      |
| Security Group   | Virtual firewall that controls traffic           |
| EBS Volume       | Elastic Block Store (persistent storage)         |
| Elastic IP       | Static IP address that can be remapped           |

---

## 🚀 Steps to Launch EC2 Instance (AWS Console)

1. **Log in to AWS Console**: https://console.aws.amazon.com/
2. Navigate to **EC2 Dashboard**
3. Click **Launch Instance**
4. Configure the following:
   - **Name**: e.g., `my-ec2-instance`
   - **AMI**: Choose Ubuntu, Amazon Linux, etc.
   - **Instance Type**: e.g., `t2.micro` (Free Tier eligible)
   - **Key Pair**: Create new or use existing (download `.pem` file)
   - **Network Settings**:
     - Create/select security group
     - Allow SSH (port 22), HTTP (80), etc.
   - **Storage**: Leave default or increase volume
5. Click **Launch Instance**
6. Go to **Instances**, select your instance, and click **Connect** to SSH

```bash
# Example SSH connection command (from terminal)
ssh -i mykey.pem ubuntu@<ec2-public-ip>
```

---

## 🧠 Common EC2 Use Cases

- Hosting web applications (LAMP, MEAN stacks)
- Running Docker containers
- Dev/Test environments
- Backend APIs
- Batch processing or data analysis

---

## 🛠 Example: Launch EC2 via AWS CLI

```bash
# Create a key pair
aws ec2 create-key-pair --key-name mykey --query 'KeyMaterial' --output text > mykey.pem
chmod 400 mykey.pem

# Launch an EC2 instance (Ubuntu)
aws ec2 run-instances \
  --image-id ami-0abcdef1234567890 \
  --count 1 \
  --instance-type t2.micro \
  --key-name mykey \
  --security-groups my-sg
```

---

## 🔐 Security Tips

- Always use key pairs for SSH (no passwords)
- Restrict SSH (port 22) access to known IPs only
- Use IAM roles instead of access keys inside EC2
- Regularly update the OS and monitor logs

---

## 🌐 EC2 Pricing Models

| Model       | Description                                |
|-------------|--------------------------------------------|
| On-Demand   | Pay per hour or second                     |
| Reserved    | Commit for 1 or 3 years for cost savings   |
| Spot        | Use unused capacity at big discount        |
| Savings Plan| Flexible option for steady-state usage     |

---

## 📎 Resources

- [EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [EC2 Pricing](https://aws.amazon.com/ec2/pricing/)
- [AWS CLI Reference](https://docs.aws.amazon.com/cli/latest/reference/ec2/)
