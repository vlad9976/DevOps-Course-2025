# Ansible

## Ansible Configuration File Precedence

Ansible determines which configuration file to use based on the following order of priority:

1. `ANSIBLE_CONFIG` – environment variable (if set)
2. `ansible.cfg` – in the current directory
3. `~/.ansible.cfg` – in the user's home directory
4. `/etc/ansible/ansible.cfg` – global default configuration

 Exercise 7 – File Copying & DB Setup

This exercise demonstrates how to use Ansible to:

- Copy a static website index file (`index.html`) to the web server.
- Deploy a database server with necessary configuration.
- Use structured Ansible inventory, configuration files, and playbooks.

---

## 🗂️ Project Structure

```
.
├── ansible.cfg           # Ansible

## Ansible Configuration File Precedence

Ansible determines which configuration file to use based on the following order of priority:

1. `ANSIBLE_CONFIG` – environment variable (if set)
2. `ansible.cfg` – in the current directory
3. `~/.ansible.cfg` – in the user's home directory
4. `/etc/ansible/ansible.cfg` – global default configuration

 configuration file
├── configurations/       # Directory for additional configuration files
├── files/
│   └── index.html        # HTML file to be copied to the web server
├── inventory             # Ansible

## Ansible Configuration File Precedence

Ansible determines which configuration file to use based on the following order of priority:

1. `ANSIBLE_CONFIG` – environment variable (if set)
2. `ansible.cfg` – in the current directory
3. `~/.ansible.cfg` – in the user's home directory
4. `/etc/ansible/ansible.cfg` – global default configuration

 inventory file with host definitions
└── db.yaml               # Playbook to configure DB server
```

---

## 🔧 Configuration Highlights

### ansible.cfg
- Sets inventory path and disables host key checking for easier automation.

### inventory
Example structure:
```ini
[web]
web01 ansible_host=192.168.56.11 ansible_user=ubuntu

[db]
db01 ansible_host=192.168.56.12 ansible_user=ubuntu
```

---

## 📦 Copying Static Files

The `index.html` file is placed inside the `files/` directory and is deployed using the `copy` module in a playbook:
```yaml
- name: Deploy website index file
  hosts: web
  tasks:
    - name: Copy index.html to /var/www/html/
      copy:
        src: files/index.html
        dest: /var/www/html/index.html
```

---

## 🛢️ Database Configuration

The `db.yaml` playbook handles:
- Installing necessary packages
- Starting DB services
- Additional configurations if provided

---

## 🚀 Running the Playbooks

To run the DB playbook:
```bash
ansible-playbook -i inventory db.yaml
```

To deploy the `index.html` page:
```bash
ansible-playbook -i inventory site.yaml
```
*(Assuming you have a playbook `site.yaml` for web tasks)*

---

## ✅ Outcome

- `index.html` deployed on the web server
- DB server installed and configured
