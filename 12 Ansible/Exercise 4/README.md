# 📘 Ansible Exercise 4 – Ad Hoc Commands

This exercise focuses on using Ansible **ad hoc commands** to quickly manage target machines without writing a full playbook. Ad hoc commands are ideal for one-time tasks such as package installation, file manipulation, and service control.

---

## 📁 Files Used

- `inventory`: Custom inventory file that defines target hosts and groups.
- `ad hoc commands`: List of frequently used Ansible ad hoc operations.

---

## 🧾 Syntax Format

```bash
ansible <host-pattern> -i <inventory-file> -m <module> -a "<arguments>"
```

---

## 🛠️ Common Ad Hoc Commands (Examples)

### 🔍 1. Test Connection to All Hosts
```bash
ansible all -i inventory -m ping
```
Checks if Ansible can reach all defined hosts using the `ping` module.

---

### 🧾 2. List Hosts
```bash
ansible all -i inventory --list-hosts
```
Lists all hosts matched by the `all` keyword in the inventory.

---

### ⏱️ 3. Uptime Check
```bash
ansible all -i inventory -a "uptime"
```
Returns how long each target machine has been running.

---

### 📂 4. Create a Directory
```bash
ansible all -i inventory -m file -a "path=/tmp/testdir state=directory mode=0755"
```
Creates a directory `/tmp/testdir` on all machines with `0755` permissions.

---

### 📦 5. Install Apache Web Server
```bash
ansible all -i inventory -m yum -a "name=httpd state=present"
```
Installs the Apache HTTP server on all Red Hat-based systems.

---

### 🔄 6. Restart Apache
```bash
ansible all -i inventory -m service -a "name=httpd state=restarted"
```
Restarts Apache service.

---

### 🧹 7. Remove Directory
```bash
ansible all -i inventory -m file -a "path=/tmp/testdir state=absent"
```
Deletes the `/tmp/testdir` directory on all hosts.

---

## 📝 Tips

- `-i inventory`: Specifies the inventory file path.
- `-m <module>`: Defines the Ansible module to use.
- `-a "<args>"`: Passes arguments to the module.
- Use `--limit <hostname>` to run the command on specific host(s).

---

## 📌 When to Use Ad Hoc Commands

✅ One-time tasks  
✅ Quick changes or checks  
❌ Not recommended for repeatable configurations — use **playbooks** instead