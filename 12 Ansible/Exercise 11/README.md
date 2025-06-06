# Ansible Exercise 11 – Multi‑Distro Provisioning & Copy Module Demo

**Objective**Provision CentOS 7 and Ubuntu 20.04 hosts with an NTP service and deploy a simple landing page, using Ansible’s `apt`, `yum`, `service`, and `copy` modules.

## Repository layout

```
.
├── ansible.cfg          # Ansible configuration (inventory path, privilege escalation)
├── inventory            # Static inventory defining CentOS and Ubuntu hosts
├── provisioning.yaml    # Main playbook that installs & starts NTP
├── index.html           # Sample page copied to /var/www/html/index.html
├── webservers/          # Host‑specific vars (exercise requirement)
├── web02/               # Additional host dir used in ad‑hoc examples
└── README.md            # You are here
```

## Playbook: `provisioning.yaml`

This single‑play playbook targets **all** hosts and performs:

1. **Install chrony on CentOS** using `yum` when `ansible_distribution == "CentOS"`
2. **Install ntp on Ubuntu** via `apt` with cache update when distribution is Ubuntu
3. **Enable & start the service** (`chronyd` on CentOS, `ntp` on Ubuntu) using the `service` module

## Static page

`index.html` is a minimal placeholder used to practice the `copy` module; the playbook (or an ad‑hoc command) pushes it to `/var/www/html/index.html` on the target hosts.

```html
<h1>Learning copy module</h1>
```

## Quick start

```bash
# 1. (Optional) activate virtualenv and install Ansible
python3 -m venv venv && source venv/bin/activate
pip install ansible

# 2. Run syntax check
ansible-playbook provisioning.yaml --syntax-check

# 3. Execute
ansible-playbook provisioning.yaml
```

### Copy the sample web page

```bash
ansible all -m copy   -a "src=index.html dest=/var/www/html/index.html owner=root group=root mode=0644"
```

## Prerequisites

- Control node with Ansible ≥ 2.16
- Passwordless SSH access (or ssh‑agent) to the hosts defined in `inventory`
- Sudo privileges on the target machines

## Notes

- The exercise demonstrates conditional task execution based on distribution facts, a common pattern when you manage mixed fleets.
- For production use consider moving distro‑specific logic into separate roles and turning the static inventory into dynamic (e.g., AWS, VMware).
