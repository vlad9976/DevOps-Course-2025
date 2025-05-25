
# ⚖️ AWS ELB (Elastic Load Balancer)

Amazon **ELB (Elastic Load Balancing)** automatically distributes incoming application traffic across multiple targets (EC2, containers, IPs) across multiple AZs.

---

## 📊 ELB Types and OSI Layer Mapping

| Load Balancer Type        | OSI Layer | Best For                                |
|---------------------------|-----------|------------------------------------------|
| **Application LB (ALB)**  | Layer 7   | Web apps with HTTP/S, path/host routing |
| **Network LB (NLB)**      | Layer 4   | High-performance TCP/UDP apps            |
| **Gateway LB (GWLB)**     | Layer 3   | Third-party network appliances           |
| **Classic LB (CLB)**      | Layer 4 & 7 | Legacy EC2-Classic apps                |

---
## 🚀 Creating an Application Load Balancer (ALB)

### 🖥️ Prerequisites

- At least 2 EC2 instances in different AZs
- A VPC with public subnets
- Security group allowing inbound HTTP (80)

### ✅ Console Steps

1. Go to **EC2 > Load Balancers > Create Load Balancer**
2. Choose **Application Load Balancer**
3. Set:
   - Name: `my-alb`
   - Scheme: Internet-facing
   - Listeners: HTTP (port 80)
4. Select **2 or more subnets** in different AZs
5. Assign security group
6. Configure or create a **Target Group**
7. Register EC2 targets
8. Review and **Create**

### 🌐 Access

After provisioning, you’ll receive a DNS like:

```
my-alb-1234567890.us-east-1.elb.amazonaws.com
```

## 🛠️ AWS CLI Example

```bash
aws elbv2 create-target-group \
  --name my-targets --protocol HTTP --port 80 --vpc-id vpc-xxxxxxx

aws elbv2 register-targets \
  --target-group-arn arn:aws:... --targets Id=i-0abc1234

aws elbv2 create-load-balancer \
  --name my-alb \
  --subnets subnet-abc subnet-def \
  --security-groups sg-01234567

aws elbv2 create-listener \
  --load-balancer-arn arn:aws:... \
  --protocol HTTP --port 80 \
  --default-actions Type=forward,TargetGroupArn=arn:aws:...
```

### 1. 🧠 Application Load Balancer (ALB)

- **OSI Layer**: Layer 7 (Application Layer)
- **Protocols**: HTTP, HTTPS, WebSocket
- **Key Features**:
  - Path-based and host-based routing
  - Supports containers (ECS) with dynamic ports
  - Native WebSocket support
  - Request-level routing (e.g. `/api`, `/login`)
- **Use Case**: Microservices, REST APIs, Single Page Applications

### 2. ⚡ Network Load Balancer (NLB)

- **OSI Layer**: Layer 4 (Transport Layer)
- **Protocols**: TCP, TLS, UDP
- **Key Features**:
  - Millions of requests/sec with ultra-low latency
  - Preserves client IP address
  - TLS offloading support
  - Supports static IP or Elastic IPs
- **Use Case**: Gaming, high-throughput services, financial services, IoT

### 3. 🛡️ Gateway Load Balancer (GWLB)

- **OSI Layer**: Layer 3 (Network Layer)
- **Protocols**: GENEVE encapsulated traffic
- **Key Features**:
  - Load balances and scales **third-party virtual appliances**
  - Integrates with VPC endpoints for centralized traffic inspection
  - Common for NGFW, IDS/IPS, DPI, traffic analyzers
- **Use Case**: Network security inspection with firewalls or packet inspection tools

### 4. 🧱 Classic Load Balancer (CLB)

- **OSI Layer**: Layer 4 & 7
- **Protocols**: HTTP, HTTPS, TCP, SSL
- **Key Features**:
  - Legacy ELB model
  - Single listener supports both TCP and HTTP-based routing
- **Use Case**: Legacy EC2-Classic applications only (not recommended for new deployments)

---

## 📦 Target Support by ELB Type

| Target Type     | ALB | NLB | GWLB |
|------------------|-----|-----|------|
| EC2 Instances     | ✅  | ✅  | ❌   |
| IP Addresses      | ✅  | ✅  | ✅   |
| Lambda Functions  | ✅  | ❌  | ❌   |
| Virtual Appliances| ❌  | ❌  | ✅   |

---

## 📎 Resources

- [ELB Overview](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/what-is-load-balancing.html)
- [ALB Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [NLB Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html)
- [GWLB Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/introduction.html)
- [ELB Pricing](https://aws.amazon.com/elasticloadbalancing/pricing/)
