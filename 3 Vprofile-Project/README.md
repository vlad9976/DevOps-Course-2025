
# 📦 vProfile Multi-Tier Application Deployment using Vagrant

This project sets up a full-stack Java-based vProfile application using Vagrant and VirtualBox. Each component runs on its own virtual machine to simulate a real production-like architecture.

---

## 🧱 Architecture

| Component   | Technology        | Hostname | Port  |
|-------------|-------------------|----------|-------|
| Database    | MariaDB           | db01     | 3306  |
| Cache       | Memcached         | mc01     | 11211 |
| Queue       | RabbitMQ          | rmq01    | 5672  |
| App Server  | Apache Tomcat + WAR | app01  | 8080  |
| Web Server  | Nginx             | web01    | 80    |

---

## 🧰 Deployment Commands (per VM)

### 🔧 Common Setup (All VMs)

```bash
cat /etc/hosts
dnf update -y || apt update && apt upgrade -y
```

---

### 🐘 DB Server (db01)

```bash
dnf install epel-release -y
dnf install git mariadb-server -y
systemctl start mariadb
systemctl enable mariadb
mysql_secure_installation

mysql -u root -padmin123
> create database accounts;
> grant all privileges on accounts.* TO 'admin'@'localhost' identified by 'admin123';
> grant all privileges on accounts.* TO 'admin'@'%' identified by 'admin123';
> FLUSH PRIVILEGES;
> exit;

cd /tmp
git clone -b local https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql
systemctl restart mariadb

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --reload
```

---

### 💾 Memcache (mc01)

```bash
dnf install epel-release -y
dnf install memcached -y
systemctl start memcached
systemctl enable memcached
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
systemctl restart memcached

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --add-port=11211/tcp
firewall-cmd --runtime-to-permanent
firewall-cmd --add-port=11111/udp
firewall-cmd --runtime-to-permanent
memcached -p 11211 -U 11111 -u memcached -d
```

---

### 📫 RabbitMQ (rmq01)

```bash
dnf install epel-release -y
dnf install wget -y
dnf -y install centos-release-rabbitmq-38
dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server
systemctl enable --now rabbitmq-server

echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config
rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
systemctl restart rabbitmq-server

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --add-port=5672/tcp
firewall-cmd --runtime-to-permanent
```

---

### ☕ App Server (app01)

```bash
dnf install epel-release -y
dnf -y install java-17-openjdk java-17-openjdk-devel git wget

cd /tmp/
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz
tar xzvf apache-tomcat-10.1.26.tar.gz
useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat
cp -r apache-tomcat-10.1.26/* /usr/local/tomcat/
chown -R tomcat.tomcat /usr/local/tomcat

# Create /etc/systemd/system/tomcat.service
# Paste systemd unit file, then run:

systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload

# Maven Setup
cd /tmp
wget https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip
unzip apache-maven-3.9.9-bin.zip
cp -r apache-maven-3.9.9 /usr/local/maven3.9
export MAVEN_OPTS="-Xmx512m"

git clone -b local https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
vim src/main/resources/application.properties  # Edit backend settings
/usr/local/maven3.9/bin/mvn install

# Deploy WAR
systemctl stop tomcat
rm -rf /usr/local/tomcat/webapps/ROOT*
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
chown tomcat.tomcat /usr/local/tomcat/webapps -R
systemctl restart tomcat
```

---

### 🌐 Web Server (web01)

```bash
apt update && apt upgrade -y
apt install nginx -y

# Create file: /etc/nginx/sites-available/vproapp
# Paste upstream config

rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
systemctl restart nginx
```

---

## 🧪 Validation

```bash
curl http://192.168.56.26       # Should return site content via nginx
systemctl status tomcat         # Check app server
mysql -u root -padmin123        # Validate DB
memcached-tool 127.0.0.1 stats  # Validate memcache
rabbitmqctl list_users          # Validate RabbitMQ
```

---

## 🧰 Vagrant Commands

```bash
vagrant up             # Start all VMs
vagrant ssh <vm_name>  # SSH into specific VM
vagrant halt           # Stop all VMs
vagrant destroy        # Remove all VMs
```

---

## 📎 Requirements

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
