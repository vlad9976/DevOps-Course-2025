
# 🛢️ AWS RDS (Relational Database Service)

**Amazon RDS** is a fully managed relational database service that supports several engines including MySQL, PostgreSQL, MariaDB, Oracle, and SQL Server. It automates tasks like backups, patching, scaling, and high availability.

---

## 📦 Key Features

- Supports multiple database engines
- Automated backups and snapshots
- Multi-AZ deployment for high availability
- Read replicas for performance and redundancy
- Integrated monitoring and logging

---

## 🧰 Use Cases

- Web and mobile applications needing persistent databases
- Legacy database migration to cloud
- Business intelligence and analytics
- SaaS applications with SQL backends

---

## 🖥️ Create RDS Instance via AWS Console

### ✅ Steps

1. Go to **RDS Console** → Click **Create Database**
2. Choose a **database creation method**: Standard or Easy Create
3. Select **engine type**: MySQL, PostgreSQL, MariaDB, etc.
4. Configure DB instance settings:
   - DB instance identifier
   - Master username and password
5. Choose instance type and storage
6. Select **VPC**, subnet group, and public access setting
7. Configure backup retention, maintenance window, and monitoring
8. Click **Create database**

### 🧪 Connect to RDS Instance

1. Ensure EC2 instance is in the same VPC and security group allows inbound traffic on the DB port
2. Use standard tools (MySQL Workbench, pgAdmin, or CLI)

```bash
mysql -h mydb.abcdefghijk.us-east-1.rds.amazonaws.com -u admin -p
```

---

## 🛠 Create RDS via AWS CLI

```bash
# Create RDS MySQL instance
aws rds create-db-instance \
  --db-instance-identifier mydbinstance \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --master-username admin \
  --master-user-password MySecurePass123 \
  --allocated-storage 20 \
  --vpc-security-group-ids sg-0123456789abcdef0 \
  --backup-retention-period 7 \
  --publicly-accessible \
  --storage-type gp2
```

```bash
# Describe RDS instances
aws rds describe-db-instances

# Delete RDS instance
aws rds delete-db-instance --db-instance-identifier mydbinstance --skip-final-snapshot
```

---

## 🧠 RDS High Availability Options

| Option         | Description                                      |
|----------------|--------------------------------------------------|
| Multi-AZ       | Automatic failover to standby in different AZ    |
| Read Replica   | Scale reads using asynchronous replicas          |
| Backups        | Daily backups and point-in-time recovery         |
| Monitoring     | CloudWatch metrics and Enhanced Monitoring       |

---

## 🔒 Security Best Practices

- Use **strong passwords** and **rotate credentials**
- Apply **security groups** to restrict DB access (port 3306, 5432, etc.)
- Enable **encryption at rest and in transit**
- Enable **Multi-AZ** for production environments

---

## 🧪 Monitoring

- View metrics in **CloudWatch**: CPUUtilization, FreeStorageSpace, ReadIOPS
- Enable **Performance Insights** for query-level visibility
- Set **CloudWatch Alarms** for health and usage thresholds

---

## 📎 Resources

- [RDS Documentation](https://docs.aws.amazon.com/rds/)
- [RDS Pricing](https://aws.amazon.com/rds/pricing/)
- [Best Practices](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.html)
- [DB Engine Features](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBEngineFeatures.html)
