
# 🛠️ Maven Build Tool - README

**Apache Maven** is a powerful build automation tool used primarily for Java projects. It automates the process of compiling, testing, packaging, and deploying applications.

---

## 🧱 What is Maven?

- **Maven** is a **build tool** used to automate the software build process.
- It uses an **XML-based build configuration file** (`pom.xml`).
- Supports building, testing, packaging, installing, and deploying Java applications.

---

## 🔁 Maven Build Lifecycle

A **Maven lifecycle** is a sequence of build phases. The key phases are:

| Phase     | Description |
|-----------|-------------|
| `validate` | Validates that the project structure is correct |
| `compile`  | Compiles the source code |
| `test`     | Runs unit tests |
| `package`  | Packages compiled code into a JAR/WAR/etc |
| `verify`   | Verifies quality checks (e.g. integration tests) |
| `install`  | Installs package into local repository |
| `deploy`   | Deploys to remote repository (shared use) |

---

## 🧪 Build Flow Summary

```text
Source Code → Compile → Test → Package → Health Checks
```

- **Source**: Java, .NET, etc.
- **Compile**: JavaC, Roslyn, etc.
- **Test**: Unit & Integration Testing
- **Package**: jar, war, zip, msi
- **Checks**: Code analysis, FindBugs, PMD

---

## 🧰 Maven Commands

```bash
mvn verify             # Verify the build without installing
mvn test               # Run unit tests and fetch dependencies
mvn clean              # Delete the target/ directory (build artifacts)
mvn install            # Compile, test, package and install into ~/.m2
mvn clean install      # Clean then build from scratch
```

---

## 📦 Dependency Management

- All downloaded dependencies are stored in:

```
~/.m2/repository/
```

- This local repository is used to avoid repeated downloads.

---

## 🏗️ Common Build Tools

| Tool      | Language/Platform | Build File Type      |
|-----------|-------------------|----------------------|
| **Maven** | Java               | `pom.xml` (XML)       |
| Ant       | Java               | XML                  |
| Gradle    | Java/Kotlin        | DSL (Groovy/Kotlin)  |
| MSBuild   | .NET               | `.csproj/.vbproj`    |
| NAnt      | .NET (legacy)      | XML                  |
| make      | C/C++/Unix         | Makefile             |

---

## 📚 Resources

- [Maven Documentation](https://maven.apache.org/guides/)
- [Lifecycle Reference](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html)
- [Maven Repositories](https://maven.apache.org/repository/index.html)
