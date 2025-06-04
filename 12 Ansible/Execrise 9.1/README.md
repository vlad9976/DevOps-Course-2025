# 🧪 Ansible Exercise 9.1 – Variable Precedence with `group_vars`

This exercise demonstrates **Ansible variable precedence** using the `group_vars` directory structure, showcasing how `all` and `webservers` group-specific variables are used. It also includes the use of the `copy` module to deploy an HTML file.

---

## 📁 Project Structure

```
├── ansible.cfg
├── inventory
├── group_vars/
│   ├── all
│   └── webservers
├── vars_precedence.yaml
└── files/
    └── index.html
```

---

## 🧩 Key Components

### 📌 `group_vars/all`
Contains variables that apply to all hosts in the inventory.

### 📌 `group_vars/webservers`
Overrides or extends variables specifically for the `webservers` group.

> 🧠 In this case, `deployment` from `webservers` takes precedence over `all`.

---

### 📄 `vars_precedence.yaml`

A simple playbook to demonstrate how Ansible applies variables based on precedence rules. It uses the `copy` module to transfer an HTML file to the target.

---

### 📁 `files/index.html`

This HTML file will be deployed to `/var/www/html/index.html`.

---

## ⚙️ Inventory & Configuration

### 🔧 `inventory`

```
[webservers]
192.168.56.11
```

### ⚙️ `ansible.cfg`

```
[defaults]
inventory = inventory
host_key_checking = False
```

---

## ✅ How to Run

```bash
ansible-playbook vars_precedence.yaml
```

---

## 📌 Notes on Variable Precedence

Ansible applies variables in the following order of priority:

1. Extra vars (always win)
2. Task vars (only for the task)
3. Block vars
4. Role vars (defined in roles)
5. `group_vars/*`
6. `host_vars/*`
7. `defaults` in roles
8. `vars_files`
9. `set_facts`
10. Inventory variables

In this example:
- `group_vars/webservers` > `group_vars/all`
- `web_port` is defined only in `webservers`
- `deployment` from `webservers` overrides `all`