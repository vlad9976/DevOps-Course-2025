
# 🪣 AWS S3 (Simple Storage Service)

**Amazon S3** is an object storage service that offers industry-leading scalability, data availability, security, and performance. It is designed to store and retrieve any amount of data from anywhere.

---

## 📦 Key Features

- Object-based storage (unlike block or file storage)
- Unlimited storage with durability (11 nines)
- Public or private access control
- Lifecycle management and versioning
- Static website hosting and serverless integration

---

## 🧰 Use Cases

- Store application data, backups, and archives
- Host static websites (HTML, CSS, JS)
- Big data analytics input/output
- Store media, logs, and documents

---

## 🖥️ Create S3 Bucket via AWS Console

### ✅ Steps

1. Go to the **S3 Console** → Click **Create Bucket**
2. Enter unique **bucket name** (globally unique)
3. Choose AWS **Region**
4. Configure options:
   - Versioning (recommended)
   - Default encryption (e.g. SSE-S3, SSE-KMS)
   - Object ownership (ACLs or Bucket owner enforced)
5. (Optional) Block all public access (recommended for private data)
6. Click **Create Bucket**

### 🧪 Upload Files

1. Click on your bucket name
2. Click **Upload** → Select files or folders
3. Click **Upload**

---

## 🛠 Create S3 Bucket via AWS CLI

```bash
# Create a bucket
aws s3api create-bucket --bucket my-bucket-name --region us-east-1

# Upload a file
aws s3 cp myfile.txt s3://my-bucket-name/

# Download a file
aws s3 cp s3://my-bucket-name/myfile.txt ./

# List buckets
aws s3 ls

# Sync folder to bucket
aws s3 sync ./myfolder s3://my-bucket-name/

# Enable versioning
aws s3api put-bucket-versioning --bucket my-bucket-name --versioning-configuration Status=Enabled
```

---

## 🌐 Static Website Hosting

1. Go to **Properties** tab of the bucket
2. Enable **Static website hosting**
3. Specify index and error documents (e.g. `index.html`, `error.html`)
4. Set appropriate **bucket policy** for public read access

### Example Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket-name/*"
    }
  ]
}
```

---

## 🔒 Security Best Practices

- Enable **encryption** (SSE-S3 or SSE-KMS)
- Enable **MFA delete** and **versioning**
- Use **bucket policies** and IAM roles to control access
- Monitor with **CloudTrail** and **CloudWatch**

---

## 🧪 Lifecycle Policies

- Automatically transition objects to Glacier/IA storage class
- Set expiration dates for unused or old files

```json
{
  "Rules": [
    {
      "ID": "MoveToGlacier",
      "Prefix": "",
      "Status": "Enabled",
      "Transitions": [
        {
          "Days": 30,
          "StorageClass": "GLACIER"
        }
      ]
    }
  ]
}
```

---

## 📎 Resources

- [S3 Docs](https://docs.aws.amazon.com/s3/)
- [S3 CLI Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/)
- [Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [Best Practices](https://aws.amazon.com/architecture/s3-best-practices/)
