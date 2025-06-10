# 🌐 AWS Project – Part 2 Overview

Welcome to Part 2 of our AWS journey! 🚀 In this phase, we're deepening our infrastructure expertise by building a real-world cloud environment with Virtual Private Cloud (VPC), Infrastructure as Code (IaC) using Terraform, and log management via EC2 + CloudWatch.

---

## 🧭 What's Inside

### 1️⃣ VPC (Virtual Private Cloud)

A VPC is your own isolated network inside AWS. It lets you define your:

* IP address ranges (CIDR blocks)
* Subnets (public/private)
* Route tables, NAT gateways, Internet gateways
* Security groups and NACLs

In this project, we architect a multi-tier VPC design that supports web, app, and DB layers, while enabling secure connectivity.

---

### 2️⃣ Terraform VPC Automation

Manually clicking through the AWS console is fine—but Terraform lets you describe your infrastructure as code. 🛠️

We’ll use Terraform to:

* Declare and provision VPC, subnets, gateways
* Spin up EC2 instances with key pairs and security groups
* Keep infrastructure repeatable, consistent, and under version control

All the Terraform files (`vpc.tf`, `keypair.tf`, `instance.tf`, etc.) are modular and reusable.

---

### 3️⃣ EC2 Logs with CloudWatch

Logging = visibility 🔍
We’ll configure:

* Apache (HTTPD) logs on our EC2 web servers
* Centralized log collection using AWS CloudWatch Logs
* Basic filtering and streaming for operational monitoring

This helps us:

* Debug traffic issues
* Monitor app health
* Stay compliant with audit trails

---

## 🔧 Who Is This For?

This setup is perfect for:

* Cloud engineers
* DevOps learners
* Anyone building AWS environments the professional way

Whether you’re automating infrastructure, managing network security, or centralizing logs, this guide has you covered. Let's dive in! 🌊
