# 🧪 Terraform Exercise 4 – EC2 Web Server Provisioning

This exercise builds upon previous Terraform setups to demonstrate how to use **remote-exec provisioners** to automate software installation (Apache Web Server) on a provisioned EC2 instance.

---

## 🎯 Objective

Provision an EC2 instance on AWS that:

- Is configured with custom variables (region, AMI, key, etc.)
- Has a custom security group
- Automatically installs Apache2 via `remote-exec`
- Uses a `web.sh` shell script for provisioning

---

## 📁 Files Overview

| File Name       | Purpose                                      |
|----------------|----------------------------------------------|
| `provider.tf`   | Configures the AWS provider                  |
| `vars.tf`       | Declares input variables                     |
| `keypair.tf`    | Creates the SSH key pair                     |
| `securityGroup.tf` | Defines the security group allowing HTTP  |
| `instance.tf`   | Provisions EC2 with remote-exec script       |
| `web.sh`        | Shell script that installs Apache2           |
| `instansID.tf`  | Outputs the instance ID                      |

---

## ⚙️ Shell Script: `web.sh`

```bash
#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
```

---

## 🧰 Remote Exec Provisioner

Located in `instance.tf`:

```hcl
provisioner "remote-exec" {
  inline = [
    "chmod +x web.sh",
    "./web.sh"
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
}
```

---

## 🚀 How to Deploy

1. **Initialize the working directory**

```bash
terraform init
```

2. **Review the execution plan**

```bash
terraform plan
```

3. **Apply the changes**

```bash
terraform apply
```

---

## ✅ Result

After a successful deployment:
- An EC2 instance is created
- Apache2 is installed and running
- Web server is accessible via public IP on port 80

Check the output for the public IP and verify using:

```bash
curl http://<public_ip>
```

---

## 🔐 Notes

Ensure:
- The `.pem` file path is correctly defined in `vars.tf`
- Port 80 is open in `securityGroup.tf`
- `web.sh` has execution permission
