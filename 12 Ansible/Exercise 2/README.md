# 🧪 Ansible Exercise 2 – Creating and Running Playbooks

This exercise demonstrates how to create a basic Ansible playbook and run it using a defined inventory file.

---

## 📁 Inventory File (`inventory`)

```ini
[web]
192.168.56.13 ansible_ssh_user=ansible

[db]
192.168.56.14 ansible_ssh_user=ansible
```

### 🔍 Explanation:
- **[web] / [db]**: These are group names that categorize your hosts.
- Each host is identified by its IP and user.
- `ansible_ssh_user=ansible` specifies which user Ansible should use to SSH into that host.

---

## 🚀 Steps to Run a Playbook

1. **Ensure SSH Access:**

```bash
ssh ansible@192.168.56.13
ssh ansible@192.168.56.14
```

2. **Ping All Hosts:**

```bash
ansible all -i inventory -m ping
```

3. **Create a Sample Playbook:**

```yaml
# playbook.yml
- name: Install and update packages
  hosts: all
  become: true
  tasks:
    - name: Update apt repo cache
      apt:
        update_cache: yes

    - name: Install Nginx
      apt:
        name: nginx
        state: present
```

4. **Run the Playbook:**

```bash
ansible-playbook -i inventory playbook.yml
```

---

## ✅ Outcome

- Nginx should be installed on all target machines (both web and db groups).
- Output will confirm successful execution per host.

---

## 🧰 Useful Commands

```bash
ansible-inventory -i inventory --list
ansible web -i inventory -m shell -a "hostname"
```

---

## 🧠 Tip

Always test your SSH access first and validate your inventory structure using `ansible-inventory`.