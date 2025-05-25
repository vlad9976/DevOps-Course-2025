
# 📂 Vagrant Synced Directory Setup (Ubuntu Jammy)

This project demonstrates how to configure a synced directory between the host and guest machine using Vagrant.

---

## 📦 Machine Configuration

| Setting        | Value             |
|----------------|-------------------|
| Box            | ubuntu/jammy64    |
| RAM            | 1600 MB           |
| CPU            | 2 Cores           |
| Private IP     | 192.168.56.14     |
| Public Network | Enabled           |
| Port Forward   | 8080 → 80         |

---

## 🔄 Synced Folder

This setup links a directory from your **host machine** to a target directory on the **guest VM**:

| Host Path   | Guest Path  |
|-------------|-------------|
| `./data/`   | `/opt/data` |

### 🖥 Example Use

- Drop scripts or files in your local `data` folder.
- Access them inside the VM at `/opt/data`.

---

## 🛠 Provisioning

The VM automatically installs Apache2 on `vagrant up` using this script:

```bash
apt-get update
apt-get install -y apache2
```

---

## 🚦 Usage

```bash
mkdir data              # Create the synced folder on host (if not exists)
vagrant up              # Start and provision the VM
vagrant ssh             # SSH into the VM
ls /opt/data            # View synced content inside the guest
```

---

## 📎 Requirements

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- Folder `./data` must exist on the host

---

## 📝 Notes

- Synced folders use VirtualBox shared folder mechanism.
- Works cross-platform (Windows, macOS, Linux). Adjust path as needed for macOS.
