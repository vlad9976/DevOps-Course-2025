# Ansible Exercise 14 – Handlers, Templates & Advanced Looping

**Objective**  
Build on previous lessons by introducing **handlers** and more sophisticated **loop/conditional** patterns while keeping the fleet‑agnostic approach for CentOS 7 and Ubuntu 20.04.

Key outcomes:

* Install multiple packages per OS via **list loops**  
* Deploy OS‑specific NTP configuration with the `template` module  
* Use **handlers** to restart services only when configuration changes  
* Drop a standard `/etc/motd` banner  
* Bulk‑create local users — simple list & dictionary variants  
* (Optional) Copy a demo `index.html` to `/var/www/html/index.html` for web tests fileciteturn19file0

---

## Repository layout

```
.
├── ansible.cfg               # Controller configuration
├── inventory                 # Static host list (CentOS & Ubuntu)
├── provisioning-loop.yaml    # Main playbook – packages, services, templates, handlers
├── loop-users.yaml           # Bulk user creation – list loop
├── dict_loop.yaml            # Bulk user creation – dictionary loop
├── playbook commands         # Examples of ad‑hoc commands used in class
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
| 1 | Install packages | `yum`, `apt` | Loops through a distro‑specific list<br>`when: ansible_distribution` |
| 2 | Copy MOTD banner | `copy` | Standard safety notice |
| 3 | Deploy NTP configs | `template` | Renders distro‑specific Jinja2 templates |
| 4 | Enable & start services | `service` | Separate task for each service *and* `notify:` triggers |
| 5 | **Handlers** | `service` | `restart ntp` runs **only if** template changed |

---

## 2 · User creation playbooks

* **`loop-users.yaml`** — creates users via a simple list loop.  
* **`dict_loop.yaml`** — loops over dictionaries to assign users to custom group(s).

---

## Quick start

```bash
# (Optional) virtualenv
python3 -m venv venv && source venv/bin/activate
pip install "ansible>=2.16"

# Connectivity check
ansible all -m ping

# Provision servers
ansible-playbook provisioning-loop.yaml

# Bulk‑add users
ansible-playbook loop-users.yaml
ansible-playbook dict_loop.yaml

# Push test web page (optional)
ansible all -m copy \
  -a "src=index.html dest=/var/www/html/index.html owner=root group=root mode=0644"

# Dry‑run?
ansible-playbook provisioning-loop.yaml --check --diff
```

---

## Key takeaways

* **Handlers** ensure services restart *only when needed*, improving efficiency.  
* Combining **templates** with handlers keeps configuration management clean & idempotent.  
* Advanced **loop + conditional** patterns reduce repetition and keep playbooks readable across multiple Linux distributions.  

---

## Prerequisites

* Control node with Python 3 & Ansible ≥ 2.16  
* SSH key‑based access to hosts in `inventory`  
* Sudo privileges on the managed nodes

Happy automating! 🚀
