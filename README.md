# Infrastructure as Code (Terraform)

This repository contains our **infrastructure as code (IaC)** definitions using [Terraform](https://www.terraform.io/).

We use Terraform to manage resources across multiple **platforms** (e.g., GitHub, Discord) and multiple **environments** (dev, staging, prod).

The goal of this repo is to:

* Provide a **single source of truth** for all infrastructure.
* Ensure **consistency** across environments.
* Enable **collaboration** and safe changes through code review and CI/CD.
* Scale easily as we add more platforms and environments.

---

## 📂 Repository Structure

```
infra-as-code/                     # Root of your Terraform repo (Git repo root)
├── README.md                      # High-level docs
├── backend.tf             # Remote backend for dev (S3/TFC/etc.)
├── main.tf                # Composes platform modules
├── providers.tf           # Provider configs (with aliases if needed)
├── variables.tf           # Env-specific variables
└── terraform.tfvars       # Inputs for this env
├── github/
│   ├── repo/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── team/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── org/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── discord/
    ├── server/
    ├── channel/
    └── role/
    

```

---

## 🏗️ Get started
  - clone the repo
  - if you want to start fresh: `make destroy-structure`: Destroy all Terraform resources and removes all current codes and directories except README and scripts folder. after than execute `init-structure`: Bootstrap Terraform repo structure (only runs if not exists)
  - make your own IAC from the fresh template!
  - otherwise you can modify my current IAC!
---


## 🏗️ Environment

* **`backend.tf`** → Defines the remote backend for storing state (e.g., S3, Terraform Cloud).
* **`providers.tf`** → Configures platform providers (GitHub, Discord, etc.).
* **`main.tf`** → Composes modules from `platforms/` to build infrastructure.
* **`variables.tf`** → Defines environment-specific variables.
* **`terraform.tfvars`** → Supplies values for variables (e.g., repo names, server configs). 

---

## 🌐 Platforms & Modules

Reusable **modules** for each platform live under `platforms/`.

### GitHub (`platforms/github/modules/`)

* **`repo/`** → Manages repositories, branch protections, repo topics.
* **`team/`** → Manages GitHub teams and memberships.
* **`org/`** → Configures org-wide settings.

### Discord (`platforms/discord/modules/`)

* **`server/`** → Manages Discord servers/guilds.
* **`channel/`** → Manages channels in a server.
* **`role/`** → Manages roles and permissions.

### Common (`platforms/common/`)

* Cross-platform helpers, like a **tags/labels** module for consistent naming.

---

## ⚙️ Provider Configuration

We use Terraform **providers** for each external system. Example:

* [GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest)
* [Discord Provider](https://registry.terraform.io/providers/aequasi/discord/latest) (community)

Each environment defines its provider config in `providers.tf`. **Credentials are never stored in Git.**
Instead, use environment variables or a credentials manager.

---

## 🚀 Workflow

1. **Branch & PR workflow**

   * Create a feature branch (`feature/new-repo`).
   * Make changes in the `environment/` or `platforms/` module.
   * Open a Pull Request → run CI (fmt, validate, plan).
   * Once approved → merge to main.

---

## 🔐 State Management

* Each environment has its own **remote backend** (`backend.tf`).
* This prevents state conflicts and isolates dev/staging/prod.
* State locking is enabled (via DynamoDB if AWS backend, or Terraform Cloud).

---

## 🧹 Code Standards

* **Terraform version:** pinned in `versions.tf`.
* **Formatting:** run `terraform fmt -recursive`.
* **Validation:** run `terraform validate` before committing.
* **Linting:** optional but recommended (`tflint`, `checkov`).
* **Modules:** always reusable, no hardcoded env-specific values.
* **Secrets:** never hardcoded, always injected via env vars or secret managers.

---

## 🧪 Example: Adding a New GitHub Repo

1. Add repo resource in `main.tf`:

```hcl
module "infra" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "infra"
    visibility  = "public"
    description = "Infra managed by Terraform"
    codereaders = []
    maintainers = []
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation", "managed"]
  }
}
```

---

## 📖 References

* [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
* [GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest)
* [Discord Provider](https://registry.terraform.io/providers/aequasi/discord/latest)
* [Terraform Module Standards](https://www.terraform.io/docs/language/modules/index.html)

---

✅ With this structure, new team members can quickly onboard:

* **Modules** → define reusable infra per platform.
* **Environments** → control where infra is deployed.
* **Backends** → ensure isolated and safe state management.
