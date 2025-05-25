
# 🤖 Jenkins Agents (Nodes) - README

Jenkins agents (formerly called "slaves") are used to **distribute build workloads**, enabling scalability, isolation, and platform diversity in CI/CD pipelines.

---

## ✅ Use Cases for Nodes

### 1. 🧠 Load Distribution

Run builds on separate nodes to reduce load on the master.

### 2. 💻 Cross-Platform Builds

Build .NET on Windows, iOS on macOS, while Jenkins master runs on Linux.

### 3. 🧪 Software Testing

Run automated test suites in parallel on dedicated agents.

---

## 📋 Prerequisites for Agent Node

1. Any OS (Ubuntu, Windows, etc.)
2. Jenkins master must have **network access** to node (firewall must allow SSH)
3. Java (JDK/JRE) installed on the agent
4. Dedicated user (e.g., `devops`) with home directory
5. Required tools installed (e.g., Maven, Git)
6. Writable Jenkins directory (e.g., `/opt/jenkins`)

---

## ⚙️ Node Setup (Ubuntu)

### 1. Create EC2 Instance (or VM)

- Name: Node1
- Security Group:
  - Allow SSH from your IP
  - Allow SSH from Jenkins SG

### 2. SSH to Node & Prepare Environment

```bash
# Install Java
sudo apt update && sudo apt install openjdk-17-jdk -y

# Create devops user
sudo adduser devops

# Configure SSH for password login
sudo vim /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
# Change: PasswordAuthentication no → yes

sudo systemctl restart ssh

# Jenkins workspace directory
sudo mkdir -p /opt/jenkins
sudo chown devops:ubuntu /opt/jenkins
sudo chmod 770 /opt/jenkins
```

---

## 🧠 Configure Jenkins Master

### 1. Add Node

- Go to: **Dashboard → Manage Jenkins → Nodes → New Node**
- Name: `Pluto`
- Executors: `1`
- Remote directory: `/opt/jenkins`
- Label: `PLUTO`
- Usage: Only build jobs with matching label
- Launch method: **SSH**
- Authentication: Username + Password (or SSH key)
- Host key verification: Non-Verifying

### 2. Disable Master for Builds (Optional)

- Go to: **Manage Jenkins → System → Master Node**
- Change usage to:
  `Only build jobs with label expressions matching this node`

---

## 🚀 Running Jobs on Nodes

### Freestyle Job

- Enable: `Restrict where this project can be run`
- Label: `PLUTO`
- Git: https://github.com/hkhcoder/vprofile-project.git
- Build step: `Invoke top-level Maven target → install`

### Declarative Pipeline

```groovy
pipeline {
  agent { label 'PLUTO' }

  tools {
    maven 'MAVEN3.9'
    jdk 'JDK17'
  }

  stages {
    stage('Fetch Code') {
      steps {
        git branch: 'atom', url: 'https://github.com/hkhcoder/vprofile-project.git'
      }
    }

    stage('Unit Test') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Build') {
      steps {
        sh 'mvn install -DskipTests'
      }
      post {
        success {
          echo 'Archiving artifact...'
          archiveArtifacts artifacts: '**/target/*.war'
        }
      }
    }
  }
}
```

---

## 🧪 Test Node Setup

1. Click the node name under **Manage Jenkins > Nodes**
2. Confirm agent is connected and remoting is working
3. Run a test job using label

---

## 📚 Resources

- [Jenkins Distributed Builds](https://www.jenkins.io/doc/book/using/using-agents/)
- [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
