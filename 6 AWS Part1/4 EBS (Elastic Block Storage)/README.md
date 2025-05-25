
# 💾 AWS EBS (Elastic Block Store)

Amazon **EBS (Elastic Block Store)** provides persistent block storage volumes for EC2 instances. It is ideal for use cases that require durable and low-latency storage such as boot volumes, databases, and app data.

---

## 📦 What is EBS?

EBS is a **network-attached storage** that persists independently from the life of an EC2 instance.

### ✅ Key Features:
- Persistent storage: retains data after instance termination (if not deleted)
- High availability within a single AZ
- Multiple volume types (SSD, HDD)
- Snapshots for backup and recovery
- Encryption support

---

## 🧱 EBS Volume Types

| Volume Type | Use Case                    | Description                          |
|-------------|-----------------------------|--------------------------------------|
| gp3         | General purpose             | Default for most workloads           |
| io2/io1     | IOPS intensive apps         | High-performance SSDs                |
| st1         | Streaming workloads         | Throughput-optimized HDD             |
| sc1         | Cold storage                | Low-cost archival HDD                |
| standard    | Magnetic (legacy)           | Deprecated, rarely used              |

---

## 🚀 Creating an EBS Volume (Console)

1. Open EC2 Dashboard → **Elastic Block Store** → **Volumes**
2. Click **Create Volume**
3. Choose:
   - Volume type (e.g., `gp3`)
   - Size in GiB
   - Availability Zone (must match EC2 instance)
4. Click **Create Volume**
5. Select volume → **Actions** → **Attach Volume**
6. Choose EC2 instance → Attach

---

## 🔧 Format and Mount EBS Volume (Linux EC2)

```bash
# List block devices
lsblk

# Format the volume (e.g., /dev/xvdf)
sudo mkfs -t ext4 /dev/xvdf

# Create mount point
sudo mkdir /data

# Mount the volume
sudo mount /dev/xvdf /data

# Persist the mount in /etc/fstab
echo '/dev/xvdf /data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab
```

---

## 🛠 AWS CLI Examples

```bash
# Create EBS volume
aws ec2 create-volume --availability-zone us-east-1a --size 8 --volume-type gp3

# List volumes
aws ec2 describe-volumes

# Attach volume to instance
aws ec2 attach-volume --volume-id vol-1234567890abcdef0 --instance-id i-0abcdef1234567890 --device /dev/xvdf

# Detach volume
aws ec2 detach-volume --volume-id vol-1234567890abcdef0

# Delete volume
aws ec2 delete-volume --volume-id vol-1234567890abcdef0
```

---

## 🔐 EBS Snapshots

- EBS volumes can be backed up using **snapshots**
- Snapshots are stored in S3 and can be used to **create new volumes**

```bash
# Create a snapshot
aws ec2 create-snapshot --volume-id vol-1234567890abcdef0 --description "Backup snapshot"

# Describe snapshots
aws ec2 describe-snapshots --owner-ids self

# Create volume from snapshot
aws ec2 create-volume --snapshot-id snap-0123456789abcdef0 --availability-zone us-east-1a
```

---

## 🧪 Best Practices

- Use `gp3` for general workloads
- Regularly backup critical data with snapshots
- Use separate volumes for OS and data
- Tag volumes for easier tracking
- Enable encryption when required

---

## 📎 Resources

- [Amazon EBS Docs](https://docs.aws.amazon.com/ebs/)
- [EBS Pricing](https://aws.amazon.com/ebs/pricing/)
- [EBS Snapshot Automation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/automate-snapshot-lifecycle.html)
