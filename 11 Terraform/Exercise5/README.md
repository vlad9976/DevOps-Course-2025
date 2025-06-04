# 🧪 Terraform Exercise 5 – EC2 with Apache Web Server and Static Website

This exercise extends EC2 provisioning by setting up a static website on an Apache web server using a remote shell script and outputs the instance's public IP.

## 🎯 Objective
Deploy an Ubuntu EC2 instance with:
- Apache2 installed
- Static HTML website deployed from a zip template
- Public IP output

---

## 📁 File Structure

| File               | Description                                      |
|--------------------|--------------------------------------------------|
| `provider.tf`       | AWS provider and region config                   |
| `vars.tf`           | Input variables (AMI, key name, instance type)  |
| `keypair.tf`        | Key pair setup using variables                   |
| `securityGroup.tf`  | Inbound rules for HTTP/SSH                       |
| `instance.tf`       | EC2 instance config with remote-exec provisioner |
| `web.sh`            | Script for installing Apache and deploying site |
| `instansID.tf`      | Outputs EC2 instance ID                          |
| `public_ip.txt`     | Public IP of deployed EC2 instance              |

---

## ⚙️ Provisioning Steps

1. Install Apache2 and unzip the website template:
```bash
#!/bin/bash
sudo apt update -y
sudo apt install -f -y
sudo apt install wget unzip apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo wget -O infinite_loop.zip https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
sudo unzip -o infinite_loop.zip -d infinite_loop
sudo cp -r infinite_loop/* /var/www/html/
sudo systemctl restart apache2
```

2. Terraform remote-exec block:
```hcl
provisioner "file" {
  source      = "web.sh"
  destination = "/tmp/web.sh"
}

provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/web.sh",
    "sudo bash /tmp/web.sh"
  ]
}
```

---

## 🔐 Security Group Rules
- **Port 22** – SSH (for provisioning)
- **Port 80** – HTTP (to serve web content)

---

## ✅ Output
Upon applying the configuration, Terraform outputs the public IP address of your instance:

```bash
terraform output public_ip
# Example output:
# 44.204.159.190
```

Visit the IP in your browser to view the deployed website.

---

## ▶️ Deployment Steps
```bash
terraform init
terraform plan
terraform apply
```

---

## 🧹 Cleanup
```bash
terraform destroy
```

---

## 🔗 Reference
- [Website Template](https://www.tooplate.com/view/2117-infinite-loop)