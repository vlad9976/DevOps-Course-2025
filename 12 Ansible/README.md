# 🧰 Ansible – Configuration Management & Automation

## 📘 Overview

Ansible is a powerful open-source automation tool used for:

- **Configuration Management**
- **Application Deployment**
- **Infrastructure as Code (IaC)**
- **Continuous Delivery and Orchestration**

This section provides hands-on examples, scripts, and explanations for using **Ansible** in DevOps workflows, primarily for managing Linux servers and deploying cloud-native infrastructure.

---

## 📌 Key Concepts

| Concept                | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| Inventory              | A file containing lists of hosts that Ansible manages                      |
| Playbook               | YAML file defining automation tasks                                        |
| Module                 | Pre-built unit of work used in playbooks (e.g., `copy`, `yum`, `apt`)      |
| Task                   | A single action performed by Ansible                                       |
| Role                   | A reusable collection of tasks, handlers, files, templates, and variables  |
| Ad-hoc Commands        | One-liners used for quick configuration or checking systems                |

---

## 🏁 Getting Started

### 🔧 Install Ansible on Ubuntu

```bash
sudo apt update
sudo apt install ansible -y
ansible --version
```

---

## 📂 Project Structure

```
ansible/
├── inventory/           # Hosts file (static or dynamic)
├── playbooks/           # Main YAML playbooks for automation
├── roles/               # Reusable roles for organized tasks
├── group_vars/          # Group-wide variable definitions
├── host_vars/           # Host-specific variable definitions
├── templates/           # Jinja2 templates
├── files/               # Static files to copy over
└── README.md            # You're here!
```

---

## ✅ Usage Examples

### Ad-hoc Command

```bash
ansible all -i inventory/hosts -m ping
```

### Run a Playbook

```bash
ansible-playbook -i inventory/hosts playbooks/setup.yml
```

---

## 🚀 Goals of This Section

- Learn Ansible syntax and structure
- Practice idempotent infrastructure setup
- Automate tasks like user management, package installs, service configuration
- Explore playbooks and roles for real-world scenarios
