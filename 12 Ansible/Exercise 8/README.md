# 📦 Ansible Exercise 8 – Variables and File Copying

This exercise demonstrates the use of **Ansible variables**, **YAML variable files**, and the **copy module** to deploy a customized HTML file to target hosts.

---

## 📁 File Structure

```
ex8/
├── ansible.cfg
├── inventory
├── db.yaml
├── variables/
│   └── variables (YAML variable file)
└── files/
    └── index.html
```

---

## 🧠 Objective

- Use external variable files for environment-specific values.
- Use `copy` module to transfer files to remote hosts.
- Replace file content dynamically using variables.
- Understand the **Ansible configuration file precedence order**.

---

## ⚙️ Configuration Files

### `ansible.cfg`
Defines the inventory path and other settings. This one is project-scoped.

```ini
[defaults]
inventory = ./inventory
remote_user = ubuntu
host_key_checking = False
```

> 🔒 **Ansible config precedence** (highest to lowest):
1. `ANSIBLE_CONFIG` environment variable (if set)
2. `ansible.cfg` in the current directory
3. `~/.ansible.cfg` in the user's home directory
4. `/etc/ansible/ansible.cfg`

---

### `inventory`

Example:
```ini
[web]
192.168.56.41
192.168.56.42

[db]
192.168.56.44
```

---

### `db.yaml`

This is the playbook used for the deployment.

```yaml
- name: Deploy Web Page to Web Servers
  hosts: web
  vars_files:
    - ./variables/variables
  tasks:
    - name: Copy custom index.html
      copy:
        src: files/index.html
        dest: /var/www/html/index.html
        mode: '0644'
```

---

### `variables/variables`

Example variable values used by the playbook.

```yaml
project_name: vprofile
environment: dev
```

You can reference these variables in templates or conditionally include them in tasks.

---

## 📄 File: `files/index.html`

```html
<h1>Learning copy module</h1>
```

You can enhance this to include variables with Jinja2 syntax if needed:

```html
<h1>Welcome to {{ project_name }} in {{ environment }} environment!</h1>
```

> Note: To render variables inside HTML, you'd need to use the `template` module instead of `copy`.

---

## ▶️ How to Run

```bash
ansible-playbook db.yaml
```

Ensure all paths and permissions are correct and target nodes are reachable.

---

## ✅ Result

After successful execution:

- `index.html` will be copied to `/var/www/html/` on all web servers.
- The file will be readable via HTTP (if Apache/Nginx is running).