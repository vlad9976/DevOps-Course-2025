
# 🔁 Full CI/CD Pipeline with Jenkins – Documentation

This repository documents the complete implementation of a Continuous Integration (CI) and Continuous Delivery (CD) pipeline using Jenkins. It includes Freestyle and Pipeline jobs, tool setup, code quality integration, artifact management, and notification setup.

---

## 🔧 Prerequisites

- Java JDK (Jenkins Dependency)
- Git (SCM Integration)
- Maven (Build Tool)
- Jenkins Installed (via APT or WAR)
- Internet connection

---

## 🧱 CI Concepts

- CI is the practice of integrating code into a shared repository several times a day.
- Automates build, test, quality checks, and packaging.

**Typical CI Flow**:

```
Source Code → Compile → Test → Package → Code Quality → Deploy → Notify
```

---

## 🚀 Jenkins Setup

### Jenkins Info:

| Property        | Value                     |
|----------------|---------------------------|
| Port           | 8080                      |
| Home Directory | `/var/lib/jenkins/`       |
| Logs           | `/var/log/jenkins/`       |

### Jenkins Installation on Ubuntu:

```bash
sudo apt update && sudo apt install openjdk-21-jdk -y

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y
```

---

## 🧰 Install Tools in Jenkins

- Navigate to: **Manage Jenkins** → **Global Tool Configuration**

### Add JDK:

```text
Name: JDK17
JAVA_HOME: /usr/lib/jvm/java-17-openjdk-amd64
```

### Add Maven:

```text
Name: maven 3.9.9
Install Automatically: Yes
Version: 3.9.9
```

---

## 🎯 Freestyle vs Pipeline

| Type       | Description                        |
|------------|------------------------------------|
| Freestyle  | GUI-based, basic CI setup          |
| Pipeline   | Groovy-based, scriptable and robust |

**Use Pipelines for production environments.**

---

## 📦 Pipeline As Code

Example `Jenkinsfile`:

```groovy
pipeline {
  agent any
  tools {
    jdk 'JDK17'
    maven 'maven 3.9.9'
  }
  stages {
    stage('Checkout') {
      steps { git 'https://github.com/your-repo/project.git' }
    }
    stage('Build & Test') {
      steps { sh 'mvn clean install' }
    }
    stage('Code Analysis') {
      steps { sh 'mvn sonar:sonar' }
    }
    stage('Quality Gate') {
      steps {
        timeout(time: 1, unit: 'HOURS') {
          waitForQualityGate abortPipeline: true
        }
      }
    }
    stage('Publish to Nexus') {
      steps { sh 'mvn deploy' }
    }
    stage('Notify') {
      steps { slackSend channel: '#jenkins-ci', message: 'Build completed' }
    }
  }
}
```

---

## 🧪 Environment Variables in Jenkins

- Inject via pipeline or **Build Environment** section.
- Can be global or per-job.

---

## 🧰 Code Analysis with SonarQube

### Jenkins Integration:

- Manage Jenkins → Global Tool Config → SonarQube Scanner
- System Config:
  - Name: `sonar-server`
  - URL: `http://<sonarQube-IP>`
  - Token: Created in SonarQube → My Account → Tokens

### Quality Gate Setup:

```groovy
stage("Quality Gate") {
  steps {
    timeout(time: 1, unit: 'HOURS') {
      waitForQualityGate abortPipeline: true
    }
  }
}
```

---

## 📊 SonarQube Quality Gates

- SonarQube → Quality Gates → Create Gate (e.g., `vprofile-QG`)
- Add Conditions (e.g., Bugs > 10)
- Project Settings → Quality Gate → Assign your custom gate

- Webhooks:
  - Project → Webhook → Name: `jenkins-ci-webhook`
  - URL: `http://<jenkins-IP>:8008/sonarqube-webhook`

---

## 📦 Nexus Repository Integration

- Nexus = Artifact Repository (runs on Java)
- Supports Maven, Docker, NPM, Ruby, etc.

**Repository Types**:
- Hosted → Internal Artifact Upload
- Proxy → External Dependency Caching
- Group → Combine hosted + proxy

### Setup:

- Go to: `http://<nexus-ip>:8081`
- Add `Maven2(hosted)` repo: Name → `vprofile-repo`

### Jenkins Credentials:

- Jenkins → Manage → Credentials → Global → Add:
  - Kind: Username + Password
  - ID: `nexuslogin`

---

## 🔔 Slack Notifications

1. Jenkins Plugin: `Slack Notification`
2. Slack App: `Jenkins CI`
3. Slack → Create channel: `#jenkins-ci`
4. Generate Slack token

### Jenkins Setup:

- Manage Jenkins → System
- Slack Config:
  - Workspace: `kraken-pt`
  - Secret Token → Added as Jenkins secret
  - Channel: `#jenkins-ci`
  - Test connection

---

## 🧾 Final Thoughts

You now have a fully functional Jenkins CI pipeline with:

- Maven + GitHub integration
- Quality checks via SonarQube
- Artifact publishing to Nexus
- Notification via Slack

Ideal for enterprise DevOps pipelines.

---

## 📚 Resources

- [Jenkins Docs](https://www.jenkins.io/doc/)
- [SonarQube](https://www.sonarsource.com/products/sonarqube/)
- [Nexus](https://www.sonatype.com/products/repository-oss)
- [Slack for DevOps](https://slack.com/solutions/devops)
