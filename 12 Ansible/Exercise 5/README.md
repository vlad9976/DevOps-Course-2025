# 🧰 Ansible Exercise 5 – Playbook for Web and DB Setup

This exercise demonstrates how to automate the provisioning of a simple infrastructure using Ansible. The infrastructure includes both a web server and a database server.

---

## 📂 Files Included

- `inventory` — Defines the target hosts for Ansible (web and DB groups).
- `web-db.yaml` — Contains playbook instructions for configuring web and database servers.

---

## 🗂️ Inventory File Structure

The `inventory` file uses a simple INI-style layout:

```ini
[web]
192.168.56.11

[db]
192.168.56.12
```

This groups the machines for specific roles in the playbook.

---

## 🧾 Playbook Overview (`web-db.yaml`)

The YAML playbook defines two tasks:
- Installing required packages on web servers
- Installing MySQL on the DB server

Basic structure:

```yaml
- name: Configure web and db servers
  hosts: all
  become: yes
  tasks:
    - name: Install Apache on web
      apt: name=apache2 state=present
      when: "'web' in group_names"

    - name: Install MySQL on DB
      apt: name=mysql-server state=present
      when: "'db' in group_names"
```

> You can expand this with handlers, roles, and templates as your project grows.

---

## 🚀 How to Run

Ensure you have SSH access to your hosts and execute:

```bash
ansible-playbook -i inventory web-db.yaml
```

Make sure to run this command from the same directory where all files exist.

---

## ✅ Expected Outcome

- Apache installed on web host(s)
- MySQL installed on DB host(s)
- Full automation of initial service deployment

---

## 📌 Notes

- Uses conditionals to apply tasks to the correct groups.
- Assumes Ubuntu-based servers (uses `apt` module).
- SSH access must be configured for passwordless authentication or Ansible will prompt.

---

