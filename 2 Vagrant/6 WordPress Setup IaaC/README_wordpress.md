
# 📰 WordPress on Vagrant (Ubuntu Focal)

This Vagrant setup installs a complete WordPress environment on Ubuntu 20.04 (Focal), including Apache, PHP, MySQL, and all required PHP extensions. It is designed for local development and testing.

---

## 🖥️ VM Configuration

| Setting        | Value           |
|----------------|------------------|
| Box            | ubuntu/focal64   |
| RAM            | 1600 MB          |
| Private IP     | 192.168.56.26    |
| Public Network | Enabled          |

---

## ⚙️ Software Installed

- Apache2
- MySQL Server
- PHP 7.x with the following extensions:
  - bcmath, curl, imagick, intl, json, mbstring, mysql, xml, zip
- WordPress (latest version)

---

## 🌐 Apache & WordPress Setup

Apache VirtualHost is configured for `/srv/www/wordpress`:
- Apache site file: `/etc/apache2/sites-available/wordpress.conf`
- WordPress downloaded to `/srv/www/wordpress`
- Default site is disabled and `mod_rewrite` is enabled

---

## 🔐 MySQL Setup

- Creates database: `wordpress`
- Creates user: `wordpress@localhost` with privileges
- Sets password in `wp-config.php`
- Injects fresh salts via WordPress API

---

## 🚀 Usage

```bash
vagrant up              # Start and provision VM
vagrant ssh             # Access VM shell
sudo systemctl status apache2  # Check Apache status
```
Access WordPress at: `http://192.168.56.26`

---

## 📎 Notes

- Default MySQL user password is `admin123` (adjust as needed)
- Synced folders are not used by default, but can be added
- WordPress salts are injected dynamically for security

---

## 🧰 Requirements

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
