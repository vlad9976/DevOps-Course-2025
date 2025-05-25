
# 📦 Vagrant VM Configuration (Ubuntu Jammy)

This project contains a `Vagrantfile` to automatically provision a virtual Ubuntu development environment using Vagrant and VirtualBox.

---

## 🚀 Features

- **Base Box**: `ubuntu/jammy64`
- **Private Network IP**: `192.168.56.14`
- **Public Network Bridging** enabled
- **Synced Folder**: Host `./data` → Guest `/opt/data`
- **Provisioning Script**:
  - Updates package lists
  - Installs Apache2

---

## 🛠 VM Resources

| Resource | Configured |
|----------|------------|
| RAM      | 1600 MB    |
| CPU      | 2 Cores    |

---

## 📂 Shared Folders

| Host Path | Guest Mount Point |
|-----------|--------------------|
| `./data`  | `/opt/data`        |

---

## 🔌 Networking

- **Private Network**: Static IP `192.168.56.14`
- **Public Network**: Bridged (visible on local network)

---

## 🧰 Provisioning Details

During `vagrant up`, the following commands run inside the guest:

```bash
apt-get update
apt-get install -y apache2
```

Apache2 will be installed and ready upon first boot.

---

## 🚦 Usage

```bash
vagrant up        # Start and provision the VM
vagrant ssh       # SSH into the VM
vagrant halt      # Stop the VM
vagrant destroy   # Delete the VM
```

---

## 📎 Requirements

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

---

## 📘 Notes

- Make sure your `./data` folder exists before running `vagrant up` to avoid sync issues.
- IP `192.168.56.14` must not conflict with other local VMs or devices.
