
# 🔧 Git Essentials README

This README provides a comprehensive walkthrough of essential Git commands and workflows for version control, collaboration, branching, merging, rollback, and remote repository management.

---

## 📁 Initial Configuration

```bash
git config --global user.name "User"
git config --global user.email "Email"
```

## 🧱 Initialize a Local Git Repository

```bash
mkdir project-directory && cd project-directory
git init                     # Initialize git repo (.git created)
git status                   # View untracked/modified files
git add .                    # Track all changes
git commit -m "Init Commit" # Commit snapshot
```

---

## 🔄 Push Local Repo to Remote (GitHub)

```bash
cd your-local-repo
git remote add origin ssh://git@github.com:vlad9976/titan.git
git branch -M main
git push -u origin main
```

---

## 🔍 Viewing Changes and History

```bash
git log                    # Full commit history
git log --oneline          # Compact view

git show <commit-id>       # View full changes of a commit

git diff                   # Unstaged changes
git diff --cached          # Staged changes
```

---

## 📥 Pulling Changes from Remote

```bash
git pull origin main
```

---

## 🌿 Branching

```bash
git branch -c "sprint1"      # Create branch (should be: -b instead of -c)
git checkout sprint1         # Switch to branch
git switch sprint1           # Alternative switch command
```

---

## 🧼 Rename / Remove Files

```bash
git rm file1 file2 file3
git mv file1 renamed-file1
```

### Example Output:

```bash
Changes to be committed:
  deleted:    gitfile2.py
  renamed:    gitfile10.py -> was-git10file.py
```

---

## 🔁 Merging Branches

```bash
git switch main
git merge sprint1
```

---

## 📥 Cloning a Repository

```bash
git clone https://github.com/vlad9976/titan.git
```

Or via SSH:

```bash
git clone git@github.com:vlad9976/titan.git
```

---

## 🧪 Rollback and Restore

### Restore File Changes

```bash
git checkout <filename>         # Restore changes before staging
git restore --staged <file>     # Unstage file
```

### Compare Commits

```bash
git diff <old-commit>..<new-commit>
```

### Revert a Commit (Safe Undo)

```bash
git revert HEAD                 # Creates a new commit that reverts the last commit
git revert <commit-id>
```

### Hard Reset (Dangerous!)

```bash
git reset --hard <commit-id>   # Resets to given commit and removes all commits after
```

---

## 🔐 SSH Authentication Setup

```bash
ssh-keygen                     # Generate SSH keys
cat ~/.ssh/id_rsa.pub          # Copy public key content

# Go to GitHub → Settings → SSH and GPG keys → New SSH key
# Paste public key

# Use SSH to clone repo
git clone git@github.com:vlad9976/titan.git
```

---

## 📌 Semantic Versioning (SemVer)

Format: **MAJOR.MINOR.PATCH**

- **MAJOR** = Backward incompatible changes
- **MINOR** = New features/improvements (compatible)
- **PATCH** = Bug fixes and small updates

### Example: `3.1.4`

- 3 = Major
- 1 = Minor
- 4 = Patch

---

## 🏷️ Annotated Tags

```bash
git tag -a v2.1.6 -m "Release for something" [optional-commit]
```

---

## 🧾 Summary Commands Cheat Sheet

| Task              | Command                             |
|-------------------|--------------------------------------|
| Init Repo         | `git init`                          |
| Stage Changes     | `git add .`                         |
| Commit            | `git commit -m "Message"`           |
| Log               | `git log --oneline`                 |
| Branching         | `git branch sprint1`                |
| Switch Branch     | `git checkout sprint1`              |
| Merge             | `git merge sprint1`                 |
| Rollback          | `git revert HEAD`                   |
| Hard Reset        | `git reset --hard <commit>`         |
| SSH Setup         | `ssh-keygen → GitHub → Add key`     |

---

## 📚 Resources

- [Git Docs](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book/en/v2)
- [GitHub SSH Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
