
# 🧰 OS Automation Tasks with Python – Secure Version (using `subprocess`)

This README covers safe and secure ways to automate Linux user and group administration tasks using Python’s `subprocess` module instead of the insecure `os.system()`.

---

## 📦 Why `subprocess` Instead of `os.system()`?

| Feature                     | ✅ `subprocess.run()` | ❌ `os.system()` |
|----------------------------|------------------------|------------------|
| Shell injection safe       | ✅ Yes                 | ❌ No            |
| Get command output/error   | ✅ Yes                 | ❌ No            |
| Raise on failure           | ✅ Yes (`check=True`)  | ❌ No            |
| Structured args (list)     | ✅ Yes                 | ❌ No            |

---

## 📁 Files Included

### ✅ `check-file.py`

Same logic as before – determines if a given path is a file or directory using `os.path`.

Run:
```bash
python3 check-file.py
```

---

### ✅ `ostasks.py` (Secure Version)

This script performs:

- Creates users `alpha`, `beta`, and `gamma` if not present
- Creates group `science` if not present
- Adds users to the group
- Creates `/opt/science_dir` with `770` permissions

All system calls are executed via `subprocess.run()` with argument lists.

---

## 🔧 Sample Functions from `ostasks.py`

```python
import subprocess
import os

def user_exists(username):
    result = subprocess.run(["id", username], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    return result.returncode == 0

def create_user(username):
    if not user_exists(username):
        subprocess.run(["useradd", username], check=True)
        print(f"User created: {username}")

def group_exists(groupname):
    result = subprocess.run(["getent", "group", groupname], stdout=subprocess.DEVNULL)
    return result.returncode == 0

def create_group(groupname):
    if not group_exists(groupname):
        subprocess.run(["groupadd", groupname], check=True)
        print(f"Group created: {groupname}")

def add_user_to_group(username, groupname):
    subprocess.run(["usermod", "-aG", groupname, username], check=True)

def setup_directory(path, groupname):
    if not os.path.isdir(path):
        os.mkdir(path)
    subprocess.run(["chown", f":{groupname}", path], check=True)
    subprocess.run(["chmod", "770", path], check=True)
```

---

## 🚀 Run Script

```bash
sudo python3 ostasks.py
```

> ⚠️ Requires `sudo` to modify users/groups and system directories

---

## 📚 References

- [Python subprocess docs](https://docs.python.org/3/library/subprocess.html)
- [Best Practices for Secure Python](https://docs.python-guide.org/writing/style/)
