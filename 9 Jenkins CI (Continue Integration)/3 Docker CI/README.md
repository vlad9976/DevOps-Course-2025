
# 🐳 Jenkins Docker CI Pipeline with AWS ECS

This project demonstrates a **CI pipeline using Jenkins**, Docker, and **Amazon ECS (Elastic Container Service)**. It includes building a Java app with Maven, containerizing it, pushing to AWS ECR, and deploying to ECS Fargate.

---

## 🎯 Objectives

- Automate build and test using Jenkins
- Perform code quality analysis via SonarQube
- Build and publish Docker image to AWS ECR
- Deploy container to ECS using Fargate
- Notify via Slack

---

## 🔧 Prerequisites

- Jenkins installed with:
  - Docker
  - Maven and JDK configured (via Global Tool Configuration)
  - AWS CLI installed and IAM permissions configured
  - Installed Plugins:
    - **Pipeline: AWS Steps**
    - **Docker Pipeline**
    - **Slack Notification**
    - **SonarQube Scanner for Jenkins**
- AWS ECR repository created
- ECS Cluster and Task Definition created
- Slack integration configured in Jenkins

---

## ⚙️ ECS Setup Summary

1. **ECS Cluster** (Fargate-based)
    - Name: `vprofile-cluster-2`
    - Monitoring: Enabled (Container Insights)

2. **Task Definition**
    - Name: `vprofile-task`
    - Container: `vproapp`
    - Image URI: From ECR
    - Port: 8080

3. **IAM Role**
    - Attach: `CloudWatchLogsFullAccess`

4. **ECS Service**
    - Name: `vprofile-app-svc`
    - Load Balancer: Application type
    - Listener: Port 80
    - Target Group: `vproapp-ecs-TG`

---

## 🔁 Jenkins Pipeline Overview

The `Jenkinsfile` includes the following stages:

```text
1. Fetch code from GitHub
2. Build the application using Maven
3. Run unit tests and checkstyle
4. Analyze code with SonarQube
5. Enforce Quality Gate
6. Build Docker image (multi-stage)
7. Push image to AWS ECR
8. Deploy to ECS via awscli
9. Clean up local Docker images
10. Send Slack Notification
```

---

## 📝 Jenkinsfile Snippet (Highlights)

```groovy
environment {
  registryCredential = 'ecr:us-east-1:awscreds'
  appRegistry = "643720661581.dkr.ecr.us-east-1.amazonaws.com/vprofileappimg"
  cluster = "vprofile-cluster-2"
  service = "vprofile-app-svc"
}

stage('Build App Image') {
  steps {
    script {
      dockerImage = docker.build(appRegistry + ":$BUILD_NUMBER", "./Docker-files/app/multistage/")
    }
  }
}

stage('Push Image to ECR') {
  steps {
    docker.withRegistry(vprofileRegistry, registryCredential) {
      dockerImage.push("$BUILD_NUMBER")
      dockerImage.push('latest')
    }
  }
}

stage('Deploy to ECS') {
  steps {
    withAWS(credentials: 'awscreds', region: 'us-east-1') {
      sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
    }
  }
}
```

---

## 🔔 Slack Notifications

Slack is integrated to notify the `#jenkins-ci` channel with build status using:

```groovy
slackSend channel: '#jenkins-ci',
  color: COLOR_MAP[currentBuild.currentResult],
  message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}"
```

---

## 📚 References

- [Amazon ECS Docs](https://docs.aws.amazon.com/ecs/latest/developerguide/)
- [Jenkins Pipeline Docs](https://www.jenkins.io/doc/book/pipeline/)
- [AWS CLI ECS Reference](https://docs.aws.amazon.com/cli/latest/reference/ecs/)
- [Docker Multi-stage Builds](https://docs.docker.com/develop/develop-images/multistage-build/)
