# 📘 Ansible Exercise 6 – Web Server Setup Using Simple Playbook (No Roles)

This exercise demonstrates how to configure a web server using a basic Ansible playbook and a static inventory. No roles or advanced structures are used.

---

## 📁 Files Used

- `inventory`: Static inventory file with web server IPs.
- `web.yaml`: The main Ansible playbook to install and start a web server.

---

## 📂 Inventory Format

Example from `inventory` file:
```ini
[web]
192.168.56.11 ansible_user=vagrant ansible_ssh_private_key_file=~/.ssh/id_rsa
```

---

## ▶️ Playbook: `web.yaml`

```yaml
- name: Install and configure Apache web server
  hosts: web
  become: true
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present
        update_cache: yes

    - name: Start and enable Apache service
      systemd:
        name: apache2
        state: started
        enabled: true
```

---

## 🚀 How to Run

```bash
ansible-playbook -i inventory web.yaml
```

---

## ✅ Expected Result

- Apache installed on all target machines.
- Apache service is running and enabled at boot.
