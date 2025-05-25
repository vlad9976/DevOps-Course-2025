
# 🐍 Python for DevOps – README

This section focuses on using Python for scripting, automation, and DevOps tooling. It includes CLI operations, scripting best practices, and DevOps-oriented use cases.

---

## 🧠 Why Python in DevOps?

- Platform-independent and preinstalled in most Linux distros
- Easy to write and maintain
- Rich ecosystem of libraries (requests, boto3, paramiko, etc.)
- Great for automation, infrastructure, monitoring, and CI/CD tasks

---

## 🛠 Common Use Cases

| Task                    | Tool/Module       |
|-------------------------|------------------|
| File manipulation       | `os`, `shutil`    |
| JSON/YAML processing    | `json`, `PyYAML`  |
| Network automation      | `paramiko`, `netmiko` |
| Cloud scripting (AWS)   | `boto3`           |
| REST APIs               | `requests`        |
| CLI Tools               | `argparse`, `click`|

---

## 🧪 Sample Script: List Files in a Directory

```python
import os

def list_files(path='.'):
    print(f"Files in directory: {path}")
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            print(f"- {file}")

if __name__ == "__main__":
    list_files()
```

---

## 📡 Sample Script: Call a REST API

```python
import requests

url = "https://api.github.com/repos/vlad9976/titan"
response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    print("Repo:", data['name'])
    print("Stars:", data['stargazers_count'])
else:
    print("Request failed:", response.status_code)
```

---

## ⚙️ Sample: Create an EC2 Instance (AWS Boto3)

```python
import boto3

ec2 = boto3.resource('ec2')

instance = ec2.create_instances(
    ImageId='ami-0abcdef1234567890',
    MinCount=1,
    MaxCount=1,
    InstanceType='t2.micro',
    KeyName='my-key',
    SecurityGroupIds=['sg-0abc123456789def0']
)

print("Created instance ID:", instance[0].id)
```

---

## 📚 Recommendations

- Use `venv` for virtual environments
- Use linters like `flake8` or `pylint`
- Follow PEP8 standards
- Use `logging` instead of `print()` for production scripts
- Document with `argparse` or `click` for CLI tools

---

## 🔗 Useful Libraries

- `requests` – REST APIs
- `boto3` – AWS scripting
- `paramiko` – SSH automation
- `docker` – Docker API control
- `kubernetes` – Manage K8s clusters
- `psutil` – Process and memory info

---

## 🧾 Run a Python Script

```bash
python3 my_script.py
```

Or make it executable:

```bash
chmod +x my_script.py
./my_script.py
```

---

## 📚 Resources

- [Python Docs](https://docs.python.org/3/)
- [Boto3 Docs](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [Requests Library](https://docs.python-requests.org/en/latest/)
- [Click for CLI](https://click.palletsprojects.com/)

