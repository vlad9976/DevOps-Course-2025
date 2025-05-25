
# 🖥️ Bash Scripting Essentials

This section introduces **Bash scripting** fundamentals and practices for automating tasks on Linux systems. Bash scripts are commonly used in DevOps, system administration, and provisioning workflows.

---

## 🧠 What is Bash Scripting?

Bash (Bourne Again SHell) is a command-line interpreter that supports scripting for automation. Bash scripts are `.sh` files containing a series of commands that execute in sequence.

---

## 🛠️ Why Use Bash Scripts?

- Automate repetitive tasks (e.g., software installs, backups)
- Provision servers (e.g., install packages, configure services)
- Schedule jobs using cron
- Monitor logs, health checks, and cleanup tasks

---

## 📝 Basic Script Structure

```bash
#!/bin/bash

# This is a comment
echo "Hello, World!"

# Variables
USER_NAME="vlad"
echo "User: $USER_NAME"

# Conditions
if [ $USER_NAME == "vlad" ]; then
  echo "Welcome back!"
fi

# Loops
for i in {1..3}; do
  echo "Line $i"
done
```

---

## 🔄 Example: System Update Script

```bash
#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Cleaning up..."
sudo apt autoremove -y

echo "Update completed."
```

---

## 🔧 Common Bash Commands in Scripts

| Task              | Command                          |
|-------------------|----------------------------------|
| Update system     | `apt update && apt upgrade -y`   |
| Install packages  | `apt install <package> -y`       |
| Set permissions   | `chmod +x script.sh`             |
| Run script        | `./script.sh`                    |
| Define variable   | `VAR=value`                      |
| Read input        | `read var`                       |
| String compare    | `[ "$a" == "$b" ]`               |
| File exists       | `[ -f filename ]`                |
| Directory exists  | `[ -d dirname ]`                 |

---

## 🧪 Execution Tips

```bash
chmod +x myscript.sh    # Make executable
./myscript.sh           # Run it
bash myscript.sh        # Run using bash explicitly
```

---

## 📦 Use Cases in DevOps

- Installing and configuring services (Apache, MySQL, etc.)
- Automating Docker/Kubernetes setup
- Parsing logs and monitoring apps
- Managing users and permissions
- Backups and scheduled cron jobs

---

## 🧩 Tips for Better Scripts

- Always start with `#!/bin/bash`
- Use `set -e` to stop on error
- Comment your logic clearly
- Use functions for modularity
- Log output and errors

---

## 📎 Next Steps

- Practice writing scripts for:
  - Package installation
  - Service status checks
  - Automating Docker container deployment
- Learn how to integrate Bash with CI/CD pipelines

