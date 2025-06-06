# Ansible Exercise 13 – Advanced Loops, Templates & Bulk User Management

**Objective**  
Automate a heterogeneous fleet (CentOS 7 & Ubuntu 20.04) by combining Ansible *loops* and the `template` module to:

* Install multiple packages in one task per OS using **list loops** fileciteturn18file0  
* Enable and manage the corresponding services idempotently fileciteturn18file5  
* Deploy a standardized banner (`/etc/motd`) fileciteturn18file0  
* Push OS‑specific NTP configuration files rendered from Jinja2 templates fileciteturn18file0  
* Create local users in bulk with **list** *and* **dictionary** loop variants fileciteturn18file1turn18file8  
* (Optional) Copy a demo web page to `/var/www/html/index.html` via `copy` fileciteturn18file2

---

## Repository layout

```
.
├── ansible.cfg              # Controller configuration
├── inventory                # Static host list (CentOS & Ubuntu)
├── provisioning-loop.yaml   # Main playbook – packages, services, MOTD, templates
├── loop-users.yaml          # Bulk user creation – simple list
├── dict_loop.yaml           # Bulk user creation – dictionary (user → groups)
├── templates/
│   ├── ntpconf_centos       # chrony.conf template
│   └── ntpconf_ubuntu       # ntp.conf template
├── index.html               # Demo page for copy module
└── README.md                # You are here
```

---

## Playbook breakdown

| # | Play/Task | Module(s) | Highlights |
|---|-----------|-----------|------------|
| 1 | **Install packages** | `yum`, `apt` | One task per OS looping over a list of packages (*chrony/wget/git/zip/unzip/httpd* for CentOS, *ntp/wget/git/zip/unzip/nginx* for Ubuntu) fileciteturn18file0 |
| 2 | **Start services** | `service` | Loops again to enable both NTP and web services per OS fileciteturn18file5 |
| 3 | **Banner (MOTD)** | `copy` | Drops a safety notice at `/etc/motd` fileciteturn18file0 |
| 4 | **NTP templates** | `template` | Renders `templates/ntpconf_centos` → `/etc/crony.conf` (CentOS) and `templates/ntpconf_ubuntu` → `/etc/ntpsec/ntp.conf` (Ubuntu) fileciteturn18file0 |
| 5 | **Restart NTP** | `service` | Restarts the NTP service to pick up the new config |
| 6 | **Bulk users** | `user`, `group` | `loop-users.yaml` adds 4 users via a list loop fileciteturn18file1; `dict_loop.yaml` adds them with group mapping in one go fileciteturn18file8 |

---

## Quick start

```bash
# 0. (optional) venv
python3 -m venv venv && source venv/bin/activate
pip install "ansible>=2.16"

# 1. Verify connectivity
ansible all -m ping

# 2. Provision servers
ansible-playbook provisioning-loop.yaml

# 3. Create users (choose one or both)
ansible-playbook loop-users.yaml      # simple list
ansible-playbook dict_loop.yaml       # dict with group assignment

# 4. Push demo web page (optional)
ansible all -m copy \
  -a "src=index.html dest=/var/www/html/index.html owner=root group=root mode=0644"

# Dry‑run?
ansible-playbook provisioning-loop.yaml --check --diff
```

---

## Key takeaways

* **Loops** drastically cut repetition while maintaining declarative state.  
* The `template` module keeps configuration logic in files, not playbooks, and supports per‑OS paths.  
* Dictionary loops add flexibility for multi‑attribute objects (e.g., user → group).  
* Pairing loops with `when:` creates clear, maintainable multi‑distro automation patterns.

---

## Prerequisites

* Control node with Python 3 and Ansible ≥ 2.16  
* SSH key‑based access to all hosts in **inventory**  
* Sudo privileges on the managed nodes

Happy automating! 🚀
