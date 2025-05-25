
# 🛠 Vagrant Provisioning Lab (CentOS Stream 9)

This project demonstrates how to provision a CentOS Stream 9 virtual machine with Vagrant. It includes package installation, directory creation, and system diagnostics output via a shell script.

---

## 📦 Machine Configuration

| Setting        | Value                               |
|----------------|--------------------------------------|
| Box            | eurolinux-vagrant/centos-stream-9    |
| IP Address     | 192.168.56.16 (private network)       |
| Public Network | Enabled                              |

---

## 📂 Provisioning Script Actions

The embedded shell script executes on `vagrant up` and performs the following actions:

```bash
yum install httpd wget unzip git -y      # Install essential packages
mkdir /opt/devops                        # Create directory
touch /opt/devops/stats                  # Create a log file
```

It then logs the following system information into `/opt/devops/stats`:
- Current date and time
- System uptime
- Current user (`whoami`)
- Available memory (`free -m`)
- Disk usage (`df -h`)

The script also echoes the contents of the file back to the terminal for verification.

---

## 🚦 Usage

```bash
vagrant up            # Boot and provision the VM
vagrant ssh           # Connect to the machine
cat /opt/devops/stats # View system stats after provisioning
vagrant halt          # Stop the machine
vagrant destroy       # Remove the machine
```

---

## 🔗 Requirements

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

---

## 📘 Notes

- This setup is great for practicing shell provisioning and system diagnostics.
- Modify the provisioning script for your own automation needs.
