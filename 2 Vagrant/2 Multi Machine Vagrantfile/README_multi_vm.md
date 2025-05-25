
# 🔗 Multi-VM Vagrant Lab

This project sets up a multi-machine environment using Vagrant. It includes 4 Ubuntu web servers and 1 CentOS database server connected via a private network.

---

## 📦 Machines Overview

| Name   | OS             | Hostname | Private IP       | Role        |
|--------|----------------|----------|------------------|-------------|
| web01  | Ubuntu Focal   | web01    | 192.168.56.41    | Web Server  |
| web02  | Ubuntu Focal   | web02    | 192.168.56.42    | Web Server  |
| web03  | Ubuntu Focal   | web02    | 192.168.56.43    | Web Server  |
| web04  | Ubuntu Focal   | web04    | 192.168.56.45    | Web Server  |
| db01   | CentOS 7       | db01     | 192.168.56.44    | Database    |

---

## ⚙️ Provisioning Details

The `db01` CentOS VM is provisioned with:

```bash
yum install -y wget unzip mariadb-server
systemctl start mariadb
systemctl enable mariadb
```

MariaDB will be installed, started, and enabled at boot.

---

## 🌐 Networking

- All machines are assigned static IPs on a private network (`192.168.56.0/24`).
- Ideal for simulating production-like environments, clustering, and practicing load balancer setups.

---

## 🚦 Usage

```bash
vagrant up          # Start and provision all VMs
vagrant status      # Check running status of each machine
vagrant ssh web01   # SSH into a specific VM
vagrant halt        # Stop all VMs
vagrant destroy     # Remove all VMs
```

---

## 📎 Requirements

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

---

## 📘 Notes

- Ensure none of the IPs conflict with existing VMs on your system.
- Modify provisioning scripts or add additional services as needed.
