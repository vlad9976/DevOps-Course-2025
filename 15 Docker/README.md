# 🐳 Docker Quick Start Guide

## 📘 Overview

Docker is a platform designed to simplify the development, shipping, and deployment of applications inside lightweight, portable containers. This guide provides the basic concepts, setup, and commands to get started with Docker.

---

## 📦 What is a Docker Container?

* A container is a lightweight, standalone executable package that includes everything needed to run a piece of software: code, runtime, libraries, and system tools.
* Containers run on a shared OS kernel but are isolated from each other.

---

## 💻 Docker Installation

Visit [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) and follow the instructions for your operating system:

* 🪟 Windows
* 🍎 macOS
* 🐧 Linux

After installation, verify it:

```bash
docker --version
```

---

## 🧠 Key Docker Concepts

* **Image** 🖼️: A blueprint for a container (e.g., Ubuntu, nginx)
* **Container** 📦: A running instance of an image
* **Dockerfile** 📜: A script to build custom Docker images
* **Docker Hub** ☁️: A cloud-based registry for Docker images

---

## 🛠️ Common Docker Commands

### 📥 Working with Images

```bash
docker pull nginx            # Download an image
docker images                # List all images
```

### 🚀 Working with Containers

```bash
docker run hello-world                   # Run a test container
docker run -it ubuntu bash               # Run Ubuntu interactively
docker run -d -p 80:80 nginx             # Run nginx in detached mode with port mapping

docker ps                                # List running containers
docker ps -a                             # List all containers

docker stop <container_id>              # Stop a running container
docker rm <container_id>                # Remove a container
```

### 🏗️ Build Custom Images

Create a `Dockerfile`:

```Dockerfile
FROM ubuntu:20.04
RUN apt update && apt install -y nginx
CMD ["nginx", "-g", "daemon off;"]
```

Build the image:

```bash
docker build -t custom-nginx .
```

Run the image:

```bash
docker run -d -p 8080:80 custom-nginx
```

---

## 💾 Docker Volumes and Networks

### 🗃️ Volumes

Used to persist data:

```bash
docker volume create mydata
docker run -v mydata:/data busybox
```

### 🌐 Networks

Used for container communication:

```bash
docker network create mynet
docker run -d --name app1 --network mynet nginx
```

---

## 🚀 Next Steps

* 🧩 Learn about Docker Compose for multi-container apps
* ☸️ Explore Docker Swarm or Kubernetes for orchestration
* 📂 Use `.dockerignore` to exclude files from builds

---

This guide covers Docker basics to help you build, ship, and run applications efficiently in containers. Happy Docking! 🐳✨
