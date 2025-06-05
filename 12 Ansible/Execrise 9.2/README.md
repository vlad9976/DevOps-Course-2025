# Ansible Exercise 9.2 — Variable Precedence (`group_vars` and `host_vars`)

This exercise demonstrates the **Ansible variable precedence model**, particularly how values are overridden between `group_vars` and `host_vars`.

## 🧩 Directory Structure

```
├── ansible.cfg
├── inventory
├── files/
│   └── index.html
├── group_vars/
│   ├── all
│   └── webservers
├── host_vars/
│   └── web02
└── vars_precedence.yaml
```

---

## 📄 File Breakdown

### `inventory`
Defines host groups like `[webservers]` and includes `web02` as a managed node.

### `ansible.cfg`
Specifies configuration such as inventory location and disables host key checking.

### `files/index.html`
HTML file copied using the `copy` module.

```html
<h1>Learning copy module</h1>
```

### `group_vars/all`
Defines global variables for all hosts.
```yaml
welcome_message: "Hello from group_vars/all"
```

### `group_vars/webservers`
Overrides variables for all members of the `webservers` group.
```yaml
welcome_message: "Hello from group_vars/webservers"
```

### `host_vars/web02`
Host-specific variable for `web02`, overriding both group layers.
```yaml
welcome_message: "Hello from host_vars/web02"
```

### `vars_precedence.yaml`
Ansible playbook that uses the `copy` module to place the `index.html` on `web02` and sets file content based on the `welcome_message` variable.

---

## 🧠 Concept: Variable Precedence

Priority from lowest to highest:
1. `group_vars/all`
2. `group_vars/{group}`
3. `host_vars/{host}`

The final value of `welcome_message` on `web02` is taken from **`host_vars/web02`**.

---

## 🚀 Run the Playbook

```bash
ansible-playbook -i inventory vars_precedence.yaml
```

You should observe the `index.html` deployed to the target node with the customized message based on host-specific variables.

---

## ✅ Expected Result

- `index.html` copied to remote server
- Contents:
  ```
  <h1>Learning copy module</h1>
  ```
- Host-specific message from `web02` reflected in debug/log (if printed)

---