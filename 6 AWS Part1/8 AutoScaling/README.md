
# 🔄 AWS Auto Scaling

**Auto Scaling** helps you maintain application availability and scale your Amazon EC2 capacity up or down automatically according to conditions you define.

---

## 📦 Key Features

- Automatically adjusts the number of EC2 instances
- Works with load balancers (ALB/NLB)
- Supports scheduled and dynamic scaling
- Integrated with CloudWatch alarms

---

## 🧰 Use Cases

- Scale web servers based on CPU load
- Handle traffic bursts during peak hours
- Ensure minimum instances are always running
- Replace unhealthy instances automatically

---

## 🛠 Create Auto Scaling Group via AWS Console

### ✅ Prerequisites

- Launch Template or Configuration
- At least one subnet and VPC
- (Optional) Load Balancer (ALB/NLB)

### 🖥️ Steps

1. Open **EC2 Console** → **Auto Scaling Groups**
2. Click **Create Auto Scaling group**
3. Set name and choose a **Launch Template**
4. Choose **VPC and Subnets**
5. (Optional) Attach to a Load Balancer
6. Configure:
   - Desired capacity (e.g., 2)
   - Minimum and maximum instance count
7. Add scaling policies:
   - Target tracking (e.g., CPU > 70%)
   - Step scaling
   - Scheduled scaling
8. Click **Create Auto Scaling Group**

---

## 🛠 Create Auto Scaling Group via AWS CLI

```bash
# 1. Create Launch Template
aws ec2 create-launch-template \
  --launch-template-name my-template \
  --version-description "v1" \
  --launch-template-data '{
    "ImageId":"ami-0abcdef1234567890",
    "InstanceType":"t2.micro",
    "SecurityGroupIds":["sg-12345678"],
    "KeyName":"mykey"
  }'

# 2. Create Auto Scaling Group
aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name my-asg \
  --launch-template LaunchTemplateName=my-template,Version=1 \
  --min-size 1 --max-size 3 --desired-capacity 2 \
  --vpc-zone-identifier "subnet-abc123,subnet-def456"

# 3. Attach CloudWatch Scaling Policy
aws autoscaling put-scaling-policy \
  --policy-name cpu-policy \
  --auto-scaling-group-name my-asg \
  --policy-type TargetTrackingScaling \
  --target-tracking-configuration '{
    "PredefinedMetricSpecification": {
      "PredefinedMetricType": "ASGAverageCPUUtilization"
    },
    "TargetValue": 60.0
  }'
```

---

## 📏 Scaling Types

| Type               | Description                            |
|--------------------|----------------------------------------|
| **Dynamic Scaling**| Reacts to CloudWatch metrics in real time |
| **Scheduled Scaling**| Based on date/time                     |
| **Predictive Scaling**| Uses machine learning to predict traffic patterns (advanced) |

---

## 🔁 Health Checks

- Auto Scaling can automatically replace unhealthy instances.
- You can use **EC2 status checks** or **ELB health checks**.

---

## 🔐 Security Best Practices

- Use IAM roles to manage access to Auto Scaling APIs
- Secure Launch Template with appropriate key pair and SGs
- Monitor activity using CloudTrail

---

## 📎 Resources

- [Auto Scaling Docs](https://docs.aws.amazon.com/autoscaling/)
- [Create ASG](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg.html)
- [Scaling Policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scale-based-on-demand.html)
