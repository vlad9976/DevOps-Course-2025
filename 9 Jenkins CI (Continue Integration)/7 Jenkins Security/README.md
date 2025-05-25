
# 🔐 Jenkins Security – README

This guide explains how to secure Jenkins using built-in authentication, user roles, and granular access control via matrix or role-based authorization.

---

## 🔑 Authentication

Jenkins supports various authentication methods:

| Method         | Description                              |
|----------------|------------------------------------------|
| Jenkins DB     | Users managed directly in Jenkins        |
| LDAP           | Connect to enterprise directory services |
| GitHub/OAuth   | External identity provider integration   |

### Enable User Sign-Up

- Go to: `Dashboard → Manage Jenkins → Configure Global Security`
- Authentication: ✅ Jenkins own user database
- Allow users to sign up

Save settings.

---

## 👥 User Roles and Permissions

### Matrix-Based Security

- Go to: `Dashboard → Manage Jenkins → Configure Global Security`
- Authorization: ✅ Matrix-based security
- Add users and assign granular permissions

Examples:
- `test123`: Read + Build on specific jobs
- `admin`: Full control

### Project-Based Authorization

- Per-job permission control
- Navigate to:
  - `Dashboard → YourJob → Configure`
  - Enable ✅ Project-based security
  - Add user (e.g. `test123`) with job-specific permissions

---

## 🧰 Role-Based Strategy (Plugin)

### Install Plugin

1. Go to: `Manage Jenkins → Plugins → Available`
2. Search: `role`
3. Install: `Role-based Authorization Strategy`

### Enable Strategy

1. Go to: `Manage Jenkins → Configure Global Security`
2. Authorization: ✅ Role-Based Strategy
3. Save

### Create & Assign Roles

- Go to: `Manage Jenkins → Manage and Assign Roles → Manage Roles`
- Add new roles (e.g., `devops`, `tester`)
- Assign individual permissions (read, build, delete, configure, etc.)

#### Assign Roles to Users

- Go to: `Manage Jenkins → Manage and Assign Roles → Assign Roles`
- Add user (e.g. `test123`) to `devops` role

---

## 👤 User Management

- With role-based plugin enabled, Jenkins will show a **Users** section.
- New users can be created via **Sign up** if enabled.
- User data is stored in Jenkins' internal database.

---

## 🔐 Job-Level Security

Enable job-level security for critical pipelines:

1. `Dashboard → Job → Configure`
2. Enable: ✅ Project-based security
3. Add users and assign per-job access (build/view/delete/configure)

---

## 🛡️ Best Practices

- Disable anonymous access (set matrix permissions carefully)
- Use role-based plugin for ease of role reuse across teams
- Limit `configure` and `delete` rights to trusted users
- Use OAuth or LDAP for central identity management in enterprise environments

---

## 📚 References

- [Jenkins Security Guide](https://www.jenkins.io/doc/book/security/)
- [Matrix Authorization Strategy Plugin](https://plugins.jenkins.io/matrix-auth/)
- [Role Strategy Plugin](https://plugins.jenkins.io/role-strategy/)
