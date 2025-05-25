
# 🌐 Vagrant Web Server Setup (CentOS Stream 9)

This Vagrant project sets up a CentOS Stream 9 virtual machine configured to run a basic web server. Apache is installed and a sample website is deployed automatically through provisioning.

---

## 🖥️ Configuration Summary

| Setting        | Value                                |
|----------------|---------------------------------------|
| Box            | eurolinux-vagrant/centos-stream-9     |
| Private IP     | 192.168.56.22                         |
| Public Network | Enabled                               |
| RAM            | 1024 MB                               |

---

## 🌍 Website Provisioning

On `vagrant up`, the following happens:

1. Updates system packages.
2. Installs Apache (`httpd`), `wget`, `vim`, `zip`, and `unzip`.
3. Sets the hostname to `webserver`.
4. Starts and enables the Apache service.
5. Downloads a sample HTML template:
   - **Template**: [Kool Form Pack (2136)](https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip)
6. Unzips it and copies it into `/var/www/html/`.
7. Reloads Apache.

📁 Final site directory: `/var/www/html/`

---

## 🚦 Usage

```bash
vagrant up            # Start and provision the VM
vagrant ssh           # SSH into the machine
curl localhost        # Test Apache server locally
```
Or open in browser: `http://192.168.56.22`

---

## ⚠️ Notes

- Make sure `192.168.56.22` is not in use on your network.
- If you're using a browser, ensure your network allows host-only/private VM access.
- Template can be changed by replacing the URL and directory names.

---

## 📎 Requirements

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
