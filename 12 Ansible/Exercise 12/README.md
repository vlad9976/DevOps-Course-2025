# Ansible Exercise 12 – Looping Constructs for Bulk Configuration

**Objective**  
Demonstrate Ansible’s `loop` keyword with **lists** and **dictionaries** to:

* Install multiple packages across CentOS 7 and Ubuntu 20.04  
* Start the matching services idempotently  
* Drop a standard MOTD banner  
* Create local users in bulk (two variants: simple list and dictionary for per‑user attributes)

---

## Repository layout

```
.
├── ansible.cfg           # Common configuration (inventory, privilege escalation)
├── inventory             # Static inventory of CentOS & Ubuntu hosts
├── provisioning-loop.yaml # Package install + service management + banner
├── loop-users.yaml       # Bulk‑user creation – simple list variant
├── dict_loop.yaml        # Bulk‑user creation – dictionary variant (user ↔ groups)
└── README.md             # You are here
```

---

## Playbooks

### 1. `provisioning-loop.yaml`

* **Packages** — Loops over a list of packages and installs them with `yum` on CentOS (chrony, httpd…) and `apt` on Ubuntu (ntp, nginx, …) fileciteturn10file1  
* **Services** — Starts the relevant services (`chronyd`/`httpd` on CentOS, `ntp`/`nginx` on Ubuntu) using another loop fileciteturn10file1  
* **Banner** — Deploys a short MOTD notice via `copy`.  

### 2. `loop-users.yaml`

Creates four local users (`test1‑4`) via a straightforward list loop fileciteturn10file2.

### 3. `dict_loop.yaml`

* Adds a **developer_test** group.  
* Creates the same four users but this time uses a loop of dictionaries, assigning each to the group in a single task fileciteturn10file0.

---

## Quick start

```bash
# 0. (Optional) Prepare a Python virtualenv
python3 -m venv venv && source venv/bin/activate
pip install ansible

# 1. Check connectivity
ansible all -m ping

# 2. Provision packages & services + banner
ansible-playbook provisioning-loop.yaml

# 3. Create the users
ansible-playbook loop-users.yaml          # simple list
ansible-playbook dict_loop.yaml           # dict variant
```

**Tip:** each playbook supports `--check` for a dry‑run and `--diff` to view file changes.

---

## Key takeaways

* `loop` makes tasks idempotent and declarative—no need for separate tasks per package or user.  
* `item` automatically represents the current element (string or dict) inside the loop.  
* Combining `loop` with conditionals (`when: ansible_distribution == ...`) is a clean way to handle multi‑distro fleets.

---

## Prerequisites

* Ansible ≥ 2.16 on the control node  
* SSH key or passwordless access to hosts in **inventory**  
* Sudo privileges on the managed hosts
