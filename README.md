# 🌩️ terraform-cloudflare-dns-automation

![Terraform](https://img.shields.io/badge/Terraform-1.13.x-623CE4?logo=terraform)
![Cloudflare](https://img.shields.io/badge/Cloudflare-5.10-orange?logo=cloudflare)
![GitHub Actions](https://img.shields.io/github/actions/workflow/status/yourusername/terraform-cloudflare-dns-automation/terraform-plan.yml?label=CI%20Status&logo=githubactions)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

Automated and reusable **Cloudflare DNS Infrastructure as Code (IaC)** project — designed for homelab environments but built with **enterprise-grade practices**.  
It provisions and manages DNS records declaratively using **Terraform**, integrates with **GitHub Actions** for CI (plan-only), and is structured for future GitOps, remote state, and multi-environment expansion.

---

## 📖 Overview

This repository demonstrates how to manage Cloudflare DNS records safely and reproducibly using Terraform, following real DevOps/Platform Engineering workflows.  
It’s a clean, minimal, and extensible setup that you can reuse for:

- Personal **homelabs** or self-hosted services (Jellyfin, Pi-hole, Vaultwarden, etc.)
- **Small-scale infrastructures** that need version-controlled DNS automation
- Educational or portfolio purposes to showcase **Terraform + GitHub Actions best practices**

At this stage, the repo includes:

- ✅ Local environment (`envs/prod/`)
- ✅ Cloudflare provider v5
- ✅ CI pipeline in GitHub Actions (format / validate / plan)
- ✅ Secrets managed via GitHub Repository Secrets
- 🚫 *No remote state or apply yet (next steps)*

---

## 🧱 Current Project Structure

```
terraform-cloudflare-dns-automation/
├── envs/
│   └── prod/
│       ├── main.tf
│       ├── providers.tf
│       ├── versions.tf
│       └── terraform.tfvars        # local only (not committed)
├── .github/
│   └── workflows/
│       └── terraform-plan.yml
├── .gitignore
└── README.md
```

---

## ⚙️ Prerequisites

| Requirement | Version | Notes |
|--------------|----------|-------|
| **Terraform** | ≥ 1.13.x | CLI installed locally or via CI |
| **Cloudflare Provider** | ≥ 5.10.x | Installed automatically on `init` |
| **Cloudflare Account** | Active domain added | Needed to manage DNS |
| **Cloudflare API Token** | Scoped to your zone | Permissions: `Zone:Read`, `DNS:Edit` |
| **GitHub Account** | For CI/CD workflow | Optional for local-only usage |

---

## 🧩 Setup Instructions (Local)

1. **Export your environment variables**

   ```bash
   export CLOUDFLARE_API_TOKEN="your_token"
   export TF_VAR_zone_id="your_zone_id"
   ```

2. **Adjust your `terraform.tfvars`**

   Example:
   ```hcl
   records = [
     { name = "demo-proof", type = "TXT", content = "managed-by-terraform", ttl = 300, proxied = false },
     { name = "docs", type = "CNAME", content = "example.com", ttl = 300, proxied = false }
   ]
   ```

3. **Run locally**

   ```bash
   cd envs/prod
   terraform init
   terraform validate
   terraform plan -var-file=terraform.tfvars
   terraform apply -auto-approve -var-file=terraform.tfvars
   ```

---

## 🤖 CI/CD: GitHub Actions Workflow

The workflow `.github/workflows/terraform-plan.yml` runs automatically on each push or pull request.

### 🔐 Required Repository Secrets

| Secret Name | Description |
|--------------|-------------|
| `CLOUDFLARE_API_TOKEN` | API token with DNS:Edit + Zone:Read permissions |
| `CF_ZONE_ID` | The Zone ID for your domain |
| `CF_RECORDS_JSON` | JSON array of DNS records for plan preview |

### 🧠 What it does

- Runs **terraform fmt**, **validate**, and **plan**
- Generates `auto.tfvars.json` dynamically from repository secrets
- Does **not** apply changes (read-only CI step for review)
- Plan output appears in the Actions logs for auditing

---

## 🚀 Next Steps (Planned Roadmap)

| Stage | Feature | Description |
|--------|----------|-------------|
| ✅ **Step 1** | Local Terraform + Cloudflare provider | Working successfully |
| ✅ **Step 2** | GitHub Actions “plan-only” CI | Automatic validation & plan per PR |
| 🔜 **Step 3** | Remote state backend (Terraform Cloud / S3 / Azure) | Enables shared state and CI apply |
| 🔜 **Step 4** | “Apply” workflow with approvals (GitHub Environments) | Safe promotion to production |
| 🔜 **Step 5** | Cloudflare Tunnel automation via Terraform + Ansible | Securely expose homelab services |
| 🔜 **Step 6** | Multi-environment setup (`dev`, `staging`, `prod`) | Environment-specific secrets & branching |

---

## 🧠 Why this structure

| Principle | Applied Practice |
|------------|-----------------|
| **Reproducibility** | Pinned versions, modular layout, declarative IaC |
| **Security** | No secrets in repo, GitHub Secrets used for tokens |
| **Scalability** | Ready for multiple environments and CI stages |
| **Reusability** | Base template usable for any domain or homelab |
| **Transparency** | Plan-only workflow allows visible infra diffs before merges |

---

## 🧪 Example Use Cases

- Add or remove DNS records safely across multiple domains  
- Manage CNAMEs for self-hosted services via GitOps  
- Learn Terraform, Cloudflare API, and CI/CD patterns  
- Template starting point for **Platform Engineering portfolios**

---

## 📚 References

- [Terraform Cloudflare Provider Docs](https://registry.terraform.io/providers/cloudflare/cloudflare/latest)
- [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
- [Cloudflare Developer Hub](https://developers.cloudflare.com/)
- [GitHub Actions for Terraform](https://github.com/hashicorp/setup-terraform)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

---

## 🧑‍💻 Author

**Carlos Chacón**  
> Homelab & DevOps enthusiast • learning-by-doing approach • automation-first mindset  

If you find this useful, feel free to **fork**, **star**, or reuse it for your own homelab or infrastructure projects.

---

**License:** MIT — free to use, adapt, and contribute.
