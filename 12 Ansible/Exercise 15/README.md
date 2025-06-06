# Ansible Exercise 15 – Variables, Handlers & File Management

**Objective**  
Expand earlier loops & template work by adding:

* Play‑level **variables** (`mydir`) and the `file` module to manage directories.  
* A **dump file** shipped to `/tmp` via `copy`.  
* **Handlers** that restart NTP services only when configuration templates change.  
* Multi‑package installation & multi‑service start using **loops** and distro checks.  
* Bulk user creation through **list** and **dictionary** loops.

---

## Repository layout

```
.
├── ansible.cfg               # Controller configuration
├── inventory                 # Static host list (CentOS 7 & Ubuntu 20.04)
├── provisioning-loop.yaml    # Main playbook – vars, packages, templates, handlers
├── loop-users.yaml           # Bulk user creation – list loop
├── dict_loop.yaml            # Bulk user creation – dict loop (user → groups)
├── templates/
│   ├── ntpconf_centos        # chrony.conf template
│   └── ntpconf_ubuntu        # ntp.conf template
├── index.html                # Demo page for copy module
└── README.md                 # You are here
```

---

## 1 · `provisioning-loop.yaml`

| Step | Task | Module(s) | Highlights |
|------|------|-----------|------------|
| 1 | Install packages | `yum`, `apt` | Loops over distro‑specific package lists (chrony/httpd vs. ntp/nginx) fileciteturn22file1 |
| 2 | Start services | `service` | Ensures NTP + web services are **started & enabled** fileciteturn22file0 |
| 3 | Banner | `copy` | Writes a motd warning at `/etc/motd` fileciteturn22file1 |
| 4 | **Create directory** | `file` | Uses play‑var `mydir: /opt/dir22` fileciteturn22file1 |
| 5 | Deploy NTP configs | `template` | Renders distro‑specific templates **and notifies** handlers fileciteturn22file1 |
| 6 | **Dump file** | `copy` | Ships `files/myfile.txt` → `/tmp/myfile.txt` fileciteturn22file1 |
| 7 | **Handlers** | `service` | `Restart Service on CentOS/Ubuntu` run only on template change fileciteturn22file4 |

---

## 2 · User creation playbooks

* **`loop-users.yaml`** — adds four users (`test1‑4`) via a simple list loop fileciteturn22file11.  
* **`dict_loop.yaml`** — creates the `developer_test` group and loops over a **dictionary** to add users and assign them to the group fileciteturn22file14.

---

## Quick start

```bash
# (optional) virtualenv
python3 -m venv venv && source venv/bin/activate
pip install "ansible>=2.16"

# Verify connectivity
ansible all -m ping

# Provision servers
ansible-playbook provisioning-loop.yaml

# Bulk‑add users
ansible-playbook loop-users.yaml     # simple list
ansible-playbook dict_loop.yaml      # dict + group

# Test handlers: edit a template then re‑run with --diff
ansible-playbook provisioning-loop.yaml --check --diff
```

---

## Key takeaways

* **Play‑level variables** keep paths configurable without hard‑coding.  
* **Handlers** prevent unnecessary restarts, improving efficiency and uptime.  
* The `file` module complements `copy`, enabling full filesystem management.  
* Using **loops + `when:`** remains the cleanest way to support mixed Linux fleets.

---

## Prerequisites

* Control node with Python 3 & Ansible ≥ 2.16  
* SSH key‑based access to hosts in `inventory`  
* Sudo privileges on the managed nodes

Happy automating! 🚀
