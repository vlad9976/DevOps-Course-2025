
# 🚀 Docker CI/CD with Jenkins and AWS ECS (Fargate)

This guide demonstrates a complete CI/CD pipeline that builds a Docker image using Jenkins, pushes it to AWS ECR, and deploys it to ECS Fargate using Jenkins Pipeline and the AWS CLI.

---

## 🧱 Components Involved

### 🔧 Local Development & Testing

- **Docker Engine**: Build and test images locally

### ☁️ Production Hosting

- **AWS ECS (Fargate)** for serverless container hosting

    Alternatives: EKS, AKS, GKE, OpenShift

### ⚙️ Jenkins

- Plugin required: `Pipeline: AWS Steps`

---

## 📦 AWS ECS Setup

### Step 1: Create ECS Cluster

```text
ECS → Clusters → Create Cluster

- Cluster Name: vprofile-cluster
- Infrastructure: AWS Fargate
- Monitoring: Enable Container Insights
- Tag: Name = Vprofile
```

### Step 2: Create Task Definition

```text
ECS → Task Definitions → Create new

- Task Definition Family: vprofile-task
- Task Role: Create new IAM Role
- Container:
    - Name: vproapp
    - Image URI: 123123.dkr.ecr.us-east-1.amazonaws.com/vprofileappimg
    - Container Port: 8080
    - Tag: vproapptask

⚠️ Add `CloudWatchLogsFullAccess` to task execution role to enable logging
```

### Step 3: Create ECS Service

```text
ECS → Clusters → vprofile-cluster → Create Service

- Task Definition Family: vprofile-task
- Service Name: vprofile-app-svc
- Revision: 1
- Disable deployment failure detection

Networking:
- Create new Security Group:
    - Name: vprofile-app-ecs-elb-SG
    - HTTP (80) from anywhere
    - TCP (8080) from anywhere

Load Balancer:
- Type: Application Load Balancer (ALB)
- Name: vproapp-elb-ecs
- Listener: Port 80
- Target Group: vproapp-ecs-TG
```

After creation, find service DNS under:

```text
ECS → Services → vprofile-app-svc → Configuration
DNS: http://vproapp-elb-ecs-123123.us-east-1.elb.amazonaws.com
```

---

## 🔧 Jenkins Configuration

### Required Plugin

- Install: **Pipeline: AWS Steps**

### Configure Jenkins:

- Add AWS credentials under **Manage Jenkins → Credentials → AWS Credentials**
- Add ECR Registry domain and Docker credentials

---

## 🧪 Jenkins Pipeline (CI/CD Flow)

Stages:

1. Checkout code from GitHub
2. Build Maven project
3. Run code quality scan (optional)
4. Build Docker image
5. Push to AWS ECR
6. Deploy to ECS Fargate
7. Cleanup old images
8. Send Slack notification

Example: `pipeline { ... }` is added via Jenkins pipeline job.

---

## 📚 Resources

- [AWS ECS Fargate](https://docs.aws.amazon.com/ecs/latest/developerguide/what-is-fargate.html)
- [Docker CLI](https://docs.docker.com/engine/reference/commandline/cli/)
- [AWS CLI ECS](https://docs.aws.amazon.com/cli/latest/reference/ecs/)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
