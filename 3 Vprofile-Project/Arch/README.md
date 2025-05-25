
# 🔄 vProfile Application Architecture Overview

This document explains the full-stack architecture of the `vProfile` Java-based web application, showcasing how services interact across different tiers.

---

## 📊 System Diagram

```
Client (HTTP request on port 80)
   ↓
 NGINX (Reverse Proxy / Load Balancer)
   ↓ (port 8080)
Apache Tomcat (Java App Server)
   ├──> Memcached (port 11211) — Caching Layer
   ├──> RabbitMQ (port 5672) — Message Queue
   └──> MySQL / MariaDB (port 3306) — Database
```

---

## 🧱 Component Breakdown

### 1. 🌐 Web Layer (Nginx)
- Accepts external HTTP traffic on **port 80**
- Forwards requests to the Tomcat server on **port 8080**
- Acts as reverse proxy / load balancer

### 2. ☕ Application Layer (Tomcat)
- Runs the vProfile Java application (`.war`)
- Communicates with backend services:
  - Memcached: for faster data access (port **11211**)
  - RabbitMQ: for asynchronous tasks (port **5672**)
  - MySQL: for persistent data (port **3306**)

### 3. 💾 Supporting Services
- **Memcached**: Caches frequent queries to reduce DB load
- **RabbitMQ**: Message broker for task distribution / decoupling
- **MySQL / MariaDB**: Main application database

---

## 🔐 Ports Summary

| Service     | Port   | Purpose              |
|-------------|--------|----------------------|
| Nginx       | 80     | HTTP Entry Point     |
| Tomcat      | 8080   | Java Web App         |
| Memcached   | 11211  | Cache                |
| RabbitMQ    | 5672   | Messaging Queue      |
| MySQL       | 3306   | Relational Database  |

---

## 🧪 Workflow Summary

1. **Client** sends request to `Nginx` (port 80)
2. Nginx forwards request to `Tomcat` (port 8080)
3. Tomcat processes the request using:
   - **Memcached** for cached data
   - **RabbitMQ** for async messaging
   - **MySQL** for data storage
4. Tomcat returns response back through Nginx to the client

---

## 📎 Notes

- Ensure all firewalls allow the necessary ports between services
- All services must have proper `/etc/hosts` entries or DNS mapping
- Designed to mimic production-ready service separation and modularity
