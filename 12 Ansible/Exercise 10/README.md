# 📦 Ansible Exercise 10 – Facts Gathering with Variable Precedence

## 📂 Project Structure

```
.
├── ansible.cfg
├── inventory
├── index.html                # HTML file to be copied to webservers
├── ansible-facts.yaml       # Playbook using facts and variables
├── vars_precedence.yaml     # Master playbook for applying precedence
├── group_vars/
│   ├── all
│   └── webservers
├── host_vars/
│   └── web02
```

---

## 🎯 Objective

Demonstrate the use of:

- `ansible_facts` to gather system facts
- Host and group variable resolution using `host_vars` and `group_vars`
- File deployment using the `copy` module
- Variable precedence and structured directory setup

---

## 🔧 Key Configuration

### 📌 ansible.cfg

Points to a custom inventory and disables host key checking for simplicity:

```ini
[defaults]
inventory = ./inventory
host_key_checking = False
```

---

### 📌 inventory

Defines a webserver host:

```ini
[webservers]
web02 ansible_host=192.168.56.12 ansible_user=ansible ansible_ssh_private_key_file=~/.ssh/id_rsa
```

---

## 📁 Variables

### 🔹 `group_vars/all`

```yaml
base_port: 80
```

### 🔹 `group_vars/webservers`

```yaml
service_name: apache2
document_root: /var/www/html
```

### 🔹 `host_vars/web02`

```yaml
index_content: "<h1>Hello from web02 via host_vars</h1>"
```

---

## 📜 Playbooks

### 📘 `ansible-facts.yaml`

Gathers facts and displays OS family and hostname:

```yaml
- name: Gather facts and display info
  hosts: webservers
  tasks:
    - name: Display OS family
      debug:
        var: ansible_facts['os_family']

    - name: Display hostname
      debug:
        var: ansible_facts['hostname']
```

### 📘 `vars_precedence.yaml`

Deploys `index.html` with content and uses variables with proper precedence.

```yaml
- name: Demonstrate variable precedence
  hosts: webservers
  tasks:
    - name: Copy index.html
      copy:
        src: index.html
        dest: "{{ document_root }}/index.html"
```

---

## ▶️ Run Commands

1. **Check facts:**

```bash
ansible-playbook ansible-facts.yaml
```

2. **Apply configuration with variables:**

```bash
ansible-playbook vars_precedence.yaml
```

---

## 📌 Notes on Variable Precedence

Ansible resolves variables in the following order:

1. `host_vars`
2. `group_vars`
3. Role defaults and other lower-priority locations (not used here)

In this example:

- `index_content` from `host_vars/web02` overrides anything from group or defaults.
- `document_root` and `service_name` from `group_vars/webservers`
- `base_port` from `group_vars/all`

---

## ✅ Output Preview

Visiting the target host's IP should display content from the `index.html` copied using `copy` module.

## Overriding Variables from the Command Line

You can overwrite the playbook variables using the command line by passing them with the `-e` option:

```bash
ansible-playbook -e USRNM=cliuser -e COMM=cliuser <Name_of_the_playbook>
```

This allows you to dynamically control the values without modifying your variable files.