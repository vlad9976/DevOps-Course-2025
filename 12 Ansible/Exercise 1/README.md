# 🧩 Ansible Exercise 1 - Basic Setup

This exercise sets up the foundational configuration for using **Ansible** effectively, including inventory management and a basic `ansible.cfg` file setup.

---
## 📁 Inventory File (`inventory`)

This file defines the hosts and groups that Ansible will manage.

### Example content:
```ini
all:
  hosts:
    web01:
      ansible_host: 172.31.31.22
      ansible_user: ec2-user
      ansible_ssh_private_key_file: target-keys.pem
```

### Explanation:
- **[web]**: This defines a group of hosts under the name `web`.
- Each line after the group name represents an individual host that can be managed.
- Hosts can be IP addresses, domain names, or aliases defined in your SSH config.

---
## ⚙️ Ansible Configuration (`ansible.cfg`)

This file customizes the behavior of Ansible and points to the correct inventory and SSH settings.

### Example content:
```ini
config file = /etc/ansible/ansible.cfg

mv ansible.cfg ansible.cfg.back

ansible-config init --disabled -t all > ansible.cfg

Uncomment chnage to false;host_key_checking=False
```

### Explanation:
- **inventory**: Path to the inventory file (set to `./inventory`).
- **remote_user**: User Ansible will use to SSH into the machines.
- **host_key_checking**: Disables host key checking to prevent prompts.
- **retry_files_enabled**: Disables creation of retry files after failed runs.

---
## ✅ How to Run a Ping Test
```bash
ansible all -m ping
```

## 🛠 Tips
- Make sure the remote user has passwordless SSH access or use `--ask-pass` flag.
- You can define multiple groups and hosts in the inventory file.