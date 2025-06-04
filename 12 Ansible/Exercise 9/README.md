# Ansible Exercise 9 – Variable Precedence & `copy` Module

This exercise demonstrates **Ansible variable precedence** as well as the usage of the **`copy` module** to deploy a custom web page using variables.

---

## 🧩 Purpose

- Practice how variables from different sources (like inventory, playbook vars, and `vars_files`) interact
- Use the `copy` module to transfer a static HTML file (`index.html`) to a remote web server

---

## 📁 File Structure

```bash
.
├── ansible.cfg              # Ansible configuration file
├── inventory                # Ansible hosts file (inventory)
├── vars_precedence.yaml     # Playbook defining variable precedence
└── files/
    └── index.html           # Web page to be copied
```

---

## ⚙️ Configuration Priority Order in Ansible

Ansible determines the configuration file using this order of priority:

1. `ANSIBLE_CONFIG` environment variable (if set)
2. `ansible.cfg` (in the current directory)
3. `~/.ansible.cfg` (in the home directory)
4. `/etc/ansible/ansible.cfg`

---

## 📦 Key Module Used

### `copy`
Copies a file from the controller machine to the target host.

```yaml
- name: Copy index.html
  ansible.builtin.copy:
    src: files/index.html
    dest: /var/www/html/index.html
```

---

## 🧪 Example Command

```bash
ansible-playbook -i inventory vars_precedence.yaml
```

---

## 🖥️ Output Preview (HTML File Copied)

Content of `index.html`:
```html
<h1>Learning copy module</h1>
```

The file will be placed at `/var/www/html/index.html` on the target system.