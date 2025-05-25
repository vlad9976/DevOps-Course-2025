
# 📂 AWS EFS (Elastic File System)

**Amazon EFS (Elastic File System)** is a fully managed, scalable NFS file system that can be mounted concurrently by multiple EC2 instances.

---

## 📦 Key Features

- Shared storage across multiple instances
- Scales automatically with storage demand
- Supports standard Linux file system semantics
- Works within a single VPC or across VPCs using Transit Gateway

---

## 🧰 Use Cases

- Web servers needing shared content
- CMS platforms (WordPress, Drupal)
- Big data workloads
- Container storage for ECS/EKS

---

## 🛠️ Create EFS via AWS Console

### ✅ Steps

1. Open **EFS Console** → Click **Create file system**
2. Name your file system (optional)
3. Select your **VPC**
4. Configure mount targets (subnets + security groups)
5. Choose **Performance mode** and **Throughput mode**
6. (Optional) Enable **encryption at rest**
7. Click **Create**

After creation:
- Copy the **Mount command** from the EFS dashboard
- Use on any EC2 instance within the VPC

```bash
# Example (from EC2 instance):
sudo yum install -y amazon-efs-utils  # or apt install on Ubuntu
sudo mkdir /mnt/efs
sudo mount -t efs fs-12345678:/ /mnt/efs
```

---

## 🔧 Create EFS via AWS CLI

```bash
# 1. Create the EFS file system
aws efs create-file-system \
  --performance-mode generalPurpose \
  --tags Key=Name,Value=my-efs

# 2. Get File System ID
aws efs describe-file-systems

# 3. Create mount target in your subnet
aws efs create-mount-target \
  --file-system-id fs-12345678 \
  --subnet-id subnet-abc123 \
  --security-groups sg-abc123
```

---

## 🔗 Mounting on EC2

1. Install EFS utilities:
```bash
sudo yum install -y amazon-efs-utils     # Amazon Linux
sudo apt install -y amazon-efs-utils     # Ubuntu
```

2. Mount:
```bash
sudo mkdir /mnt/efs
sudo mount -t efs fs-12345678:/ /mnt/efs
```

3. Optional: Add to `/etc/fstab` for auto-mounting on reboot

```fstab
fs-12345678:/ /mnt/efs efs defaults,_netdev 0 0
```

---

## 🔒 Security

- Use security groups to allow NFS traffic (port 2049) between EFS and EC2
- Use IAM for access control to the EFS APIs (not file access)
- Encryption at rest is supported (via AWS KMS)

---

## 📎 Summary Table

| Resource         | Requirement             |
|------------------|--------------------------|
| Subnets          | One in each AZ required  |
| Security Group   | NFS port 2049 open       |
| OS Packages      | `amazon-efs-utils`       |
| Mount Point      | Accessible from EC2      |

---

## 📚 Resources

- [Amazon EFS Documentation](https://docs.aws.amazon.com/efs/)
- [Mount EFS](https://docs.aws.amazon.com/efs/latest/ug/mounting-fs.html)
- [EFS vs EBS vs FSx](https://aws.amazon.com/storage/)
