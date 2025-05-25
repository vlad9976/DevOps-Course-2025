
# 📈 AWS CloudWatch: Metrics and Monitoring

**Amazon CloudWatch** enables real-time monitoring of AWS resources and custom applications through metrics, logs, alarms, and dashboards.

---

## 📊 What Are Metrics?

Metrics are data points that measure the performance of resources (e.g. CPU usage, disk I/O, Lambda duration). Metrics can come from AWS services or be **custom-defined** by you.

---

## ✅ Add Monitoring and Metrics from the AWS Console

### 🖥️ Step-by-Step: View and Add Monitoring

#### 📍 For EC2 Instance
1. Open **EC2 Console**
2. Go to **Instances** → Select an instance
3. Scroll to **Monitoring** tab
4. Click **Enable Detailed Monitoring** (1-minute intervals instead of 5)
5. Click **View in CloudWatch** to open the metrics in CloudWatch

#### 📍 From CloudWatch Console
1. Go to **CloudWatch Console**
2. In the left menu, click **Metrics**
3. Browse by namespace (e.g., `EC2`, `EBS`, `Lambda`)
4. Select metrics (checkbox) and click **Add to dashboard** or **Create alarm**

### 🧪 Create an Alarm (From Console)

1. Go to **CloudWatch Console** → **Alarms** → **Create Alarm**
2. Choose metric (e.g. `EC2 > Per-Instance Metrics > CPUUtilization`)
3. Set conditions:
   - Threshold type: Static or Anomaly detection
   - Operator: Greater than 80%
4. Set notification action (e.g., send to SNS topic or email)
5. Name your alarm and **Create Alarm**

---

### 📍 Example: EC2 CPU Alarm
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name "HighCPU" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=i-0123456789abcdef0 \
  --evaluation-periods 2 \
  --alarm-actions arn:aws:sns:us-east-1:123456789012:MyTopic \
  --unit Percent
```

## 📏 Custom Metrics (from Application)

You can publish your own metrics via AWS CLI or SDK.

```bash
aws cloudwatch put-metric-data \
  --namespace "MyApp" \
  --metric-name "LoginLatency" \
  --dimensions Page=/login \
  --value 0.25
```

---

## 📊 Dashboards

1. Go to **CloudWatch Console** → **Dashboards**
2. Click **Create dashboard**
3. Add widgets for metrics, alarms, and logs
4. Arrange widgets to visualize app performance

---

## 🔁 Monitor Logs

- From **EC2 or Lambda**, configure logs to go to CloudWatch
- Use **Log Insights** to query logs
- Set filters to create metrics from logs (e.g., count `ERROR` entries)

---

## 📎 Summary

| Feature           | Console Path                          |
|------------------|----------------------------------------|
| View EC2 Metrics | EC2 → Instance → Monitoring tab        |
| View All Metrics | CloudWatch → Metrics                   |
| Create Alarm     | CloudWatch → Alarms → Create Alarm     |
| Add Dashboard    | CloudWatch → Dashboards                |
| View Logs        | CloudWatch → Log Groups → Log Streams  |

---

## 📚 Resources

- [CloudWatch Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html)
- [Create Alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- [Dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html)
