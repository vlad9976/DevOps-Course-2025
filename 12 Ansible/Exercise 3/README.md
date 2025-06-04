# 🧩 Ansible Exercise 3 – Using Variables

This exercise introduces **Ansible variables**, enabling you to customize playbook behavior for more dynamic and reusable automation.

---

## 📂 File Structure

```
.
├── inventory              # Inventory file with defined hosts
├── group_vars/
│   └── [group_name].yml   # Variables specific to a host group
├── host_vars/
│   └── [host_name].yml    # Variables specific to an individual host
├── playbook.yml           # Main playbook referencing variables
```

---

## 📘 What You’ll Learn

- How to define **host-level** and **group-level** variables
- How to access variables inside playbooks using `{{ variable_name }}`
- How variable **precedence** affects behavior
- Debugging variables with the `debug` module

---

## 📌 Sample Usage of Variables in a Playbook

```yaml
- name: Demo Playbook with Variables
  hosts: web
  vars:
    custom_message: "Welcome to Ansible Exercise 3"
  tasks:
    - name: Print the message
      ansible.builtin.debug:
        msg: "{{ custom_message }}"
```

---

## 🗂️ Inventory Example

```
[web]
192.168.56.13 ansible_user=ubuntu
```

---

## 💡 Tips

- Group variables go in: `group_vars/web.yml`
- Host-specific variables go in: `host_vars/192.168.56.13.yml`
- You can override variables via CLI:  
  `ansible-playbook playbook.yml -e "custom_message='Hello from CLI'"`

---

## ▶️ Run the Playbook

```bash
ansible-playbook -i inventory playbook.yml
```

---

## ✅ Outcome

After successful execution, you will see messages or configuration results personalized based on your variable settings.