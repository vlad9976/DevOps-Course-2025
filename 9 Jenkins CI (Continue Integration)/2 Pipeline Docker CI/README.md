
# 🐳 Docker CI/CD Setup for Jenkins with AWS ECR

This guide outlines all the prerequisites and setup steps needed to configure a Jenkins CI/CD pipeline using Docker and AWS Elastic Container Registry (ECR).

---

## 📦 Prerequisites

### 🔐 AWS

- IAM user with programmatic access
- ECR registry (Docker registry on AWS)

### 🔧 Jenkins

- Plugins required:
  - Docker
  - Docker Pipeline
  - Amazon ECR
  - AWS SDK for credentials

- Credentials:
  - Store AWS account access keys as global credentials

---

## 🔧 Setup Instructions

### 1. 🐋 Install Docker on Jenkins

SSH into your Jenkins host and run:

```bash
# Add Docker repository
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Then install Docker:

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
```

Ensure Jenkins user is added to the Docker group:

```bash
sudo usermod -aG docker jenkins
sudo reboot
```

---

### 2. ☁️ Create IAM User for Jenkins

AWS Console → IAM → Users → Create New User

- Name: `jenkins`
- Permissions:
  - AmazonEC2ContainerRegistryFullAccess
  - AmazonECS_FullAccess

Then create access keys under Security Credentials tab.

---

### 3. 🛢️ Create AWS ECR Registry

Go to **Amazon ECR** in the AWS Console:

- Repository name: `vprofileappimg`
- Visibility: Private
- Create

---

### 4. 🔌 Install Jenkins Plugins

Go to: **Dashboard → Manage Jenkins → Plugins → Available**

Search and install:

- `Amazon Web Services SDK :: ECR`
- `Amazon ECR`
- `Docker Pipeline`
- `CloudBees Docker Build and Publish`

---

### 5. 🔐 Store AWS Credentials in Jenkins

**Dashboard → Manage Jenkins → Credentials → System → Global Credentials**

- Kind: AWS Credentials
- ID: `awscreds`
- Access Key: From IAM user
- Secret Key: From IAM user

---

## 🧪 Execution Summary

```text
1. Install Docker Engine and reboot Jenkins host
2. Configure IAM user with ECR/ECS access
3. Create AWS ECR registry
4. Install Docker and AWS plugins in Jenkins
5. Add AWS credentials to Jenkins
6. Start writing Jenkins pipelines to build/push to ECR
```

---

## 📚 References

- [Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [AWS ECR Docs](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)
- [Jenkins Plugin Index](https://plugins.jenkins.io/)
