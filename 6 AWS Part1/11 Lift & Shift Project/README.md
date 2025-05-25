
# 🚀 VProfile Project - AWS Lift & Shift

This project showcases the **Lift and Shift** migration of the VProfile application into the AWS cloud using IaaS components and managed services.

---

## 🎯 Objective

- Flexible, scalable infrastructure
- No upfront cost
- Effective modernization
- Full use of IaaS + AWS best practices

---

## 🛠 AWS Services Used

| Service         | Purpose                               |
|------------------|----------------------------------------|
| EC2             | VM for app, db, cache, message queue   |
| S3 / EFS        | Shared artifact and file storage       |
| ELB             | Load balancer for app servers          |
| Auto Scaling    | Automatically scale EC2 fleet          |
| Route 53        | Private DNS and custom domains         |
| ACM             | SSL certificate management             |
| IAM             | Role-based access and control          |

---

## 🧱 Architecture Overview

- EC2 for backend components (MySQL, Memcache, RabbitMQ)
- EC2 for app server (Tomcat)
- S3 for artifact storage
- EFS for shared file mounts
- ALB with HTTPS termination and Route 53 custom DNS
- Auto Scaling for dynamic capacity handling

---

## 🔄 Execution Flow

1. **Login to AWS**
2. **Create Key Pair** (vprofile-prod-key)
3. **Create 3 Security Groups** for ELB, App, Backend
4. **Launch EC2 Instances** for:
   - DB (MySQL)
   - Memcache
   - RabbitMQ
   - App (Tomcat)
5. **Run Configuration Scripts** on each instance using User Data:
   - MySQL EC2 → 📝 MySQL Script
   - Memcache EC2 → 📝 Memcache Script
   - RabbitMQ EC2 → 📝 RabbitMQ Script
   - App EC2 (Ubuntu) → 📝 Tomcat Script
6. **Configure DNS via Route 53**
7. **Build WAR artifact** using Maven
8. **Upload WAR to S3**
9. **Download and deploy artifact on App EC2**
10. **Setup ALB + HTTPS (via ACM)** and map DNS via GoDaddy
11. **Enable Auto Scaling for app server with Launch Template**
12. **Verify app on HTTP and HTTPS**

---

## 🔐 Security Group Setup

| SG Name            | Rules                                                                  |
|--------------------|------------------------------------------------------------------------|
| Vprofile-ELB-SG    | HTTP(80), HTTPS(443) from 0.0.0.0/0                                     |
| Vprofile-APP-SG    | TCP 8080 from ELB SG, SSH(22) from MyIP                                |
| Vprofile-Backend-SG| MySQL(3306), Memcache(11211), RabbitMQ(5672), SSH, All Internal Traffic |

---

## ☁️ Application Components

| Component     | Hostname (Private DNS)  | Port    |
|---------------|--------------------------|---------|
| MySQL         | db01.vprofile.in         | 3306    |
| Memcache      | mc01.vprofile.in         | 11211   |
| RabbitMQ      | rmq01.vprofile.in        | 5672    |
| App (Tomcat)  | app01                    | 8080    |

All mapped via Route 53 Private Hosted Zone: `vprofile.in`

---

## 📦 Artifact Deployment

- Build with Maven:
```bash
mvn install
```
- Upload WAR to S3:
```bash
aws s3 cp target/vprofile-v2.war s3://vprofile-las-artifacrs999/
```
- SSH into App EC2, fetch WAR from S3, and deploy to Tomcat:
```bash
aws s3 cp s3://vprofile-las-artifacrs999/vprofile-v2.war /tmp/
sudo systemctl stop tomcat10
sudo rm -rf /var/lib/tomcat10/webapps/ROOT
sudo cp /tmp/vprofile-v2.war /var/lib/tomcat10/webapps/ROOT.war
sudo systemctl start tomcat10
```

---

## 🌐 Load Balancer + DNS

- ALB with Target Group on port 8080
- ACM certificate for HTTPS
- GoDaddy DNS points `vprofileapp.domain.com` to ALB DNS

Example access:
- HTTP: `http://vprofile-las-elb-xyz.us-east-1.elb.amazonaws.com`
- HTTPS: `https://vprofileapp.dgday.online/`

---

## 📈 Auto Scaling Setup

- Create AMI from configured app instance
- Launch Template: `vprofile-APP01-LT`
- Auto Scaling Group: `vprofile-APP-ASG`
  - Target tracking policy: avg CPU = 50%
  - Health checks via ELB
- Stickiness enabled on Target Group

---

## ✅ Troubleshooting

- Check `application.properties` file for DNS misconfigurations:
```bash
cat /var/lib/tomcat10/webapps/ROOT/WEB-INF/classes/application.properties
```

---

## 📚 References

- [Project Repo](https://github.com/hkhcoder/vprofile-project/tree/awsliftandshift)
- AWS Console: EC2, RDS, ELB, S3, IAM, Route 53, ACM
