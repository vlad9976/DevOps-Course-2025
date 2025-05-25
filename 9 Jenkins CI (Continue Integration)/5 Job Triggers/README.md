
# 🔔 Jenkins Job Triggers – README

This guide covers various ways to automatically trigger Jenkins jobs. It includes Git-based triggers, polling strategies, remote execution, scheduled builds, and chaining jobs.

---

## 📌 Supported Jenkins Triggers

| Trigger Type                      | Description                                                      |
|----------------------------------|------------------------------------------------------------------|
| **Git Webhook**                  | Trigger on git push events using GitHub webhooks                 |
| **Poll SCM**                     | Periodically check Git repo for changes                          |
| **Build Periodically**           | Scheduled job execution using Cron syntax                        |
| **Remote Trigger**               | Trigger job via external script or webhook with token            |
| **Build after Other Projects**   | Trigger job after dependent project builds                       |

---

## 🧱 Prerequisites

1. Git repository with SSH access
2. Jenkins credentials (SSH key)
3. A Jenkinsfile committed in your repo
4. A pipeline job configured with:  
   - SCM: Git (SSH)  
   - Branch: */main  
   - Script path: `Jenkinsfile`

---

## 1️⃣ Git Webhook Trigger

### GitHub Setup

- Go to your GitHub repo → **Settings → Webhooks**
- Add Webhook:

```
Payload URL: http://<jenkins-ip>:8080/github-webhook/
Content type: application/json
Events: Just the push event
```

### Jenkins Job Config

- Go to Job → Configure → Triggers:
  - ✅ GitHub hook trigger for GITScm polling

Trigger the job by committing new file:

```bash
touch trigger-file
git add . && git commit -m "Trigger build" && git push
```

---

## 2️⃣ Poll SCM Trigger

### Jenkins Job Config

- Go to Job → Configure → Triggers:
  - ✅ Poll SCM
  - Schedule: `* * * * *` (every minute)

Jenkins will check the repo every minute and trigger the job if it detects changes.

---

## 3️⃣ Build Periodically (Cron)

Trigger builds at a fixed schedule, regardless of repo changes.

### Jenkins Job Config

- Go to Job → Configure → Triggers:
  - ✅ Build periodically
  - Schedule: `30 20 * * 1-5` → every weekday at 20:30

---

## 4️⃣ Remote Trigger via Token

Trigger job externally using HTTP calls.

### Jenkins Job Config

- Go to Job → Configure → Triggers:
  - ✅ Trigger builds remotely
  - Authentication Token: `mybuildtoken`

### Call from CLI

```bash
curl -X POST "http://<jenkins-ip>:8080/job/<job-name>/build?token=mybuildtoken"
```

#### With Crumb and Auth:

```bash
# Get Jenkins Crumb
wget -q --auth-no-challenge --user <username> --password <password> \
  --output-document - 'http://<jenkins-ip>:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'

# Trigger job
curl -I -X POST http://<username>:<APITOKEN>@<jenkins-ip>:8080/job/<job-name>/build?token=mybuildtoken -H "Jenkins-Crumb:<crumb>"
```

---

## 5️⃣ Trigger After Another Job

Trigger a job after a dependent job completes.

- Create Freestyle or Pipeline job
- Go to **Configure** → **Build Triggers**:
  - ✅ Build after other projects are built
  - Projects to watch: `Build`
  - Only trigger if previous job is stable

---

## ⚠️ Common Issue: SSH Host Key Verification

You may see this error in the console log:

```
HOST KEY Verification failed
```

### Fix:

- Go to **Dashboard → Manage Jenkins → Security**
- Find: **Git Host Key Verification Configuration**
- Strategy: `Accept first connection`
- Save

---

## 🛠 Example: Create Pipeline Job

- Name: `Build`
- Pipeline from SCM
- Repo: `git@github.com:vlad9976/jenkins-triggers.git`
- Credentials: `SSH key (gitsshkey)`
- Script path: `Jenkinsfile`

---

## 📚 Resources

- [GitHub Webhooks](https://docs.github.com/en/webhooks)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
- [Jenkins CLI Reference](https://www.jenkins.io/doc/book/managing/cli/)
