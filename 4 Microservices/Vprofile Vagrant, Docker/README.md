
# 📦 vProfile on Docker Containers (with Vagrant)

This project provisions a Vagrant VM running Ubuntu, installs Docker and Docker Compose, and deploys the `vProfile` multi-tier application as containerized services.

---

## 🛠️ Stack Components

| Service      | Docker Image                    | Port   | Role               |
|--------------|----------------------------------|--------|--------------------|
| vprodb       | `vprocontainers/vprofiledb`      | 3306   | MySQL DB           |
| vprocache01  | `memcached`                      | 11211  | In-memory Cache    |
| vpromq01     | `rabbitmq`                       | 15672  | Message Broker     |
| vproapp      | `vprocontainers/vprofileapp`     | 8080   | Tomcat Java App    |
| vproweb      | `vprocontainers/vprofileweb`     | 80     | Nginx Web Frontend |

---

## ⚙️ Vagrant VM Configuration

- **Base Box**: Ubuntu Focal (20.04)
- **Memory**: 2048 MB
- **Private IP**: `192.168.56.82`
- **Public Network**: Enabled

The VM is automatically provisioned to install:
- Docker Engine
- Docker Compose CLI
- Required dependencies

---

## 🐳 Docker Compose Configuration

**File:** `docker-compose.yml`

```yaml
version: '3.8'
services:
  vprodb:
    image: vprocontainers/vprofiledb
    ports: ["3306:3306"]
    volumes: [vprodbdata:/var/lib/mysql]
    environment:
      - MYSQL_ROOT_PASSWORD=vprodbpass

  vprocache01:
    image: memcached
    ports: ["11211:11211"]

  vpromq01:
    image: rabbitmq
    ports: ["15672:15672"]
    environment:
      - RABBITMQ_DEFAULT_USER=guest
      - RABBITMQ_DEFAULT_PASS=guest

  vproapp:
    image: vprocontainers/vprofileapp
    ports: ["8080:8080"]
    volumes: [vproappdata:/usr/local/tomcat/webapps]

  vproweb:
    image: vprocontainers/vprofileweb
    ports: ["80:80"]

volumes:
  vprodbdata: {}
  vproappdata: {}
```

---

## 🚀 Setup Instructions

```bash
# 1. Start the VM
vagrant up

# 2. SSH into the VM
vagrant ssh

# 3. Clone your repo or copy the docker-compose.yml
cd ~
nano docker-compose.yml

# 4. Start the vProfile stack
docker-compose up -d

# 5. View running containers
docker ps
```

---

## 🌐 Access Points

| Service     | URL/Port                      |
|-------------|-------------------------------|
| Web (Nginx) | http://192.168.56.82:80        |
| App (Tomcat)| http://192.168.56.82:8080      |
| RabbitMQ UI | http://192.168.56.82:15672     |
| Memcache    | Port 11211 (no UI)            |
| MySQL       | Port 3306 (CLI/Workbench)     |

---

## 🧪 Useful Commands

```bash
docker-compose logs -f       # View logs for all services
docker-compose down          # Stop and remove containers
docker volume ls             # View volumes
docker exec -it vprodb bash  # Access a container shell
```

---

## 📎 Notes

- Ensure the VM has internet access for pulling images
- Host OS must support virtualization and allow bridged adapter
- Volumes help persist DB and WAR data even after containers are stopped

