
# 🤖 Fabric Python Automation – README

This `fabfile.py` provides a set of automation tasks using [Fabric](https://www.fabfile.org/), a Python library for remote execution and DevOps scripting.

Fabric allows us to perform local and remote server tasks such as installing packages, uploading files, restarting services, and provisioning infrastructure.

---

## 📦 Requirements

Install Fabric 1.x (used for this script):

```bash
pip install fabric==1.14
```

> For Fabric 2.x or 3.x, syntax differs significantly.

---

## 📂 File: `fabfile.py`

### 1. `greeting(msg)`

Prints a greeting message:

```bash
fab greeting:Morning
```

### 2. `system_info()`

Displays local system disk, RAM, and uptime info:

```bash
fab system_info
```

### 3. `remote_exec()`

Runs remote system checks and installs MariaDB:

```bash
fab -H <remote_host> remote_exec
```

**Steps executed remotely:**

- Show hostname, uptime, disk, and memory usage
- Install `mariadb-server`
- Start and enable the service

### 4. `web_setup(WEBURL, DIRNAME)`

Sets up a basic web server with HTML template:

```bash
fab web_setup:http://example.com/template.zip,template-folder
```

**Steps performed:**

- Install required packages
- Download template from `WEBURL`
- Unzip, repackage, and upload to `/var/www/html`
- Restart `httpd`

---

## 🛠 Usage Example

1. Ensure passwordless SSH is configured or use `--prompt-for-pass`.
2. Run:

```bash
fab -H 192.168.1.10 remote_exec
```

or

```bash
fab greeting:Evening
fab system_info
fab web_setup:http://site.com/theme.zip,myfolder
```

---

## ⚠️ Notes

- Fabric 1.x uses `fabric.api`
- For Fabric 2+, see the updated syntax at https://docs.fabfile.org/en/stable/upgrading.html
- Run all tasks from the directory containing `fabfile.py`

---

## 📚 References

- [Fabric Documentation](https://www.fabfile.org/)
- [Fabric GitHub Repo](https://github.com/fabric/fabric)
- [Python Paramiko (SSH Library)](https://www.paramiko.org/)
