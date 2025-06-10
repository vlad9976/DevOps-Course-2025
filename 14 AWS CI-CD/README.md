# 🚀 AWS CI/CD Deployment Guide

## 🌐 Overview

Welcome to your step-by-step adventure into the world of AWS-powered CI/CD! 🎯 This guide helps you launch a Java web application using Bitbucket, Elastic Beanstalk, RDS, CodeBuild, and CodePipeline—all on the cloud. No fluff. Just flow. 💡

---

## 🍃 1. Deploying with Elastic Beanstalk

Elastic Beanstalk = AWS's magical wrapper for EC2, Load Balancer, Auto Scaling & more.

### 🎬 Launch in Style:

1. 🔐 Create a key pair in EC2: `vpro-beankey`
2. 🌱 Go to **Elastic Beanstalk** > Create Application:

   * Name: `vprofile`
   * Environment: `vprofile-prod-23`
   * Platform: Tomcat 10 + Corretto 21 (Amazon Linux 2023)
   * Instance Type: `t2.micro`
   * Min/Max instances: 2/4 (Auto Scaling)
   * Storage: GP3
   * Public IP: Enabled
   * Subnets: Select All ✅
   * Tags: `project:vprofile`
   * Enable Load Balancer stickiness 🧷
   * Deployment: Rolling (50%)
3. 🧾 Submit and grab a ☕ while AWS does the magic.

---

## 🛢️ 2. Set Up Your MySQL RDS

Reliable backend? ✅ Use RDS for managed MySQL goodness.

### 🛠️ Steps:

1. Go to **RDS** > Create database:

   * Engine: MySQL 8.0.35
   * Identifier: `vpro-RDS`
   * Username: `admin`, Password: Auto-generate (save it!)
   * Instance: `t3.micro`, Free Tier
   * Initial DB: `accounts`
   * SG: Create `vpro-RDS-SG`

2. 🔐 Open port 3306 to Elastic Beanstalk SG

3. 💻 Initialize DB:

   * SSH into EB EC2
   * Install MariaDB client:

     ```bash
     sudo dnf install mariadb105 -y
     ```
   * Import DB:

     ```bash
     wget <db_backup_url>
     mysql -h <rds-endpoint> -u admin -p accounts < db_backup.sql
     ```

---

## 🧑‍💻 3. Bitbucket Repository Setup

Bitbucket = Your source of truth. Git + CI/CD integration 💙

### 🧾 Do this:

1. Create repo `vproapp` (private, no README/.gitignore)
2. Generate SSH keys:

   ```bash
   ssh-keygen -t rsa -b 4096
   ```
3. Paste public key into Bitbucket > Settings > SSH Keys
4. Add SSH config:

   ```bash
   vim ~/.ssh/config
   Host bitbucket.org
     PreferredAuthentications publickey
     IdentityFile ~/.ssh/your_key
   ```
5. Clone, re-point, and push from GitHub:

   ```bash
   git clone https://github.com/hkhcoder/vprofile-project.git
   cd vprofile-project && git checkout aws-ci
   git remote rm origin
   git remote add origin git@bitbucket.org:devops/vproapp.git
   git push origin --all
   ```

---

## 🏗️ 4. Build with CodeBuild

CodeBuild compiles, tests, and packages. It’s the engine room of your CI.

### ⚙️ Set it up:

1. Create S3 bucket: `awscicd34234`
2. Go to **CodeBuild** > Create project:

   * Name: `vproapp-build`
   * Source: Bitbucket (create app connection 🔗)
   * OS: Ubuntu
   * Buildspec: paste from `/src/aws-ciaws-files/buildspec.yml`

     * 🛠️ Update DB endpoint + credentials
   * Artifacts: Push to your S3
   * Logs: CloudWatch (optional but 🔥 for debugging)

---

## 🔄 5. Automate with CodePipeline

CodePipeline stitches source, build, and deploy into a beautiful CI/CD cycle.

### 🧵 Stitch it together:

1. Create Pipeline: `vprocicdpipeline`
2. Source: Bitbucket (`aws-ci` branch)
3. Build: Select CodeBuild project
4. Deploy: Elastic Beanstalk

   * App: `vprofile`
   * Env: `vprofile-prod-23`

### 🔐 IAM Permissions:

* Go to IAM > Roles > `AWSCodePipelineServiceRole-*`
* Attach `AdministratorAccess-AWSElasticBeanstalk`

Push to Bitbucket and voila! 🚀 It builds, tests, and deploys automatically.

---

## ✅ 6. Test Your Pipeline

1. Commit changes to `aws-ci`
2. Watch CodePipeline in action
3. Visit Beanstalk Load Balancer URL

   * 👤 Login: `admin_vp`
   * 🔒 Password: `admin_vp`

---

## 🎉 You're Live!

CI/CD complete. From commit to deploy—automated. Reusable. Scalable. That’s DevOps done right.
