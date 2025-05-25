
# 🐧 Linux Quickstart Guide

A hands-on Linux quickstart reference for learning commands, managing users, understanding permissions, and operating services across Ubuntu, CentOS, and more.

---

## 📚 Topics Covered with Examples

### 1. Introduction to Linux

**Distributions**:
- Desktop: Ubuntu, Fedora
- Server: Ubuntu Server, RHEL, CentOS

**Package Formats**:
- DEB (Debian/Ubuntu): `dpkg -i file.deb`
- RPM (RHEL/CentOS): `rpm -ivh file.rpm`

---

### 2. Essential Linux Commands

| Task                    | Command Example                          |
|-------------------------|-------------------------------------------|
| Show current directory  | `pwd`                                     |
| List contents           | `ls -la`                                  |
| Change directory        | `cd /etc`                                 |
| Create directory        | `mkdir testdir`                           |
| Create empty file       | `touch test.txt`                          |
| Copy file               | `cp test.txt backup.txt`                  |
| Move file               | `mv test.txt /tmp/`                       |
| Delete file             | `rm backup.txt`                           |
| Delete folder           | `rm -r testdir`                           |

---

### 3. VIM Editor

**Basic Usage**:
```bash
vim notes.txt          # Open file
i                      # Enter insert mode
<write text>           
Esc                    # Exit insert mode
:wq                    # Save and quit
```

**Command Mode Shortcuts**:
- `dd`: delete line
- `yy`: copy line
- `p`: paste below
- `/word`: search "word"
- `:set nu`: show line numbers

---

### 4. Filtering & I/O Redirection

| Task                         | Command                                  |
|------------------------------|-------------------------------------------|
| Find lines with "root"       | `grep root /etc/passwd`                   |
| Case-insensitive search      | `grep -i root /etc/passwd`                |
| Exclude lines with "daemon"  | `grep -v daemon /etc/passwd`             |
| Show first 10 lines          | `head /etc/passwd`                        |
| Show last 5 lines            | `tail -n 5 /etc/passwd`                   |
| Output to file               | `echo "Hello" > hello.txt`                |
| Append to file               | `echo "Again" >> hello.txt`               |
| Redirect errors              | `ls /fake 2>> errors.log`                 |
| Pipe output                  | `ps aux | grep nginx`                     |

---

### 5. Users & Groups

| Task                        | Command                                 |
|-----------------------------|------------------------------------------|
| Add user                    | `sudo adduser john`                      |
| Set password                | `sudo passwd john`                       |
| Delete user & home          | `sudo userdel -r john`                   |
| Create group                | `sudo groupadd devs`                     |
| Add user to group           | `sudo usermod -aG devs john`             |
| Show current user           | `whoami`                                 |
| List logged-in users        | `who`                                    |

---

### 6. File Permissions

**Symbolic Mode**:
```bash
chmod u+x script.sh    # Add execute to user
chmod go-r file.txt    # Remove read from group & others
```

**Numeric Mode**:
```bash
chmod 755 run.sh       # rwxr-xr-x
chmod 640 report.txt   # rw-r----- 
```

---

### 7. Sudo Access

| Task                         | Command                                 |
|------------------------------|------------------------------------------|
| Run command as root          | `sudo apt update`                        |
| Become root                  | `sudo -i`                                |
| Switch to another user       | `su - john`                              |
| Add user to sudoers group    | `usermod -aG sudo john` (Ubuntu)         |

---

### 8. Software Management

**Ubuntu (APT)**:
```bash
sudo apt update                         # Update packages
sudo apt install apache2 -y            # Install Apache2
sudo apt remove apache2 -y             # Remove Apache2
```

**CentOS (YUM/RPM)**:
```bash
sudo yum update                        # Update all
sudo yum install httpd -y             # Install Apache2
sudo yum remove httpd -y              # Remove it
sudo rpm -ivh file.rpm                 # Install RPM package
```

---

### 9. Service Management (systemctl)

| Task                         | Command (Ubuntu/CentOS)                 |
|------------------------------|------------------------------------------|
| Start service                | `sudo systemctl start apache2`          |
| Stop service                 | `sudo systemctl stop apache2`           |
| Enable on boot              | `sudo systemctl enable apache2`         |
| Disable on boot             | `sudo systemctl disable apache2`        |
| Check status                 | `sudo systemctl status apache2`         |

---

## 📦 Useful Resources

- [LinuxNix Blog](http://www.linuxnix.com/)
- [Red Hat YUM Cheat Sheet](https://access.redhat.com/sites/default/files/attachments/rh_yum_cheatsheet_1214_jcs_print-1.pdf)
- [APT Command Guide](https://itsfoss.com/apt-command-guide/)
- [DNF RPM Guide](https://www.linuxtechi.com/dnf-command-examples-rpm-management-fedora-linux/)

---

## 📝 License

Open educational resource. Feel free to clone, contribute, and share. 📘
