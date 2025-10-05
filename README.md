# 🌩️ terraform-cloudflare-dns-automation

![Terraform](https://img.shields.io/badge/Terraform-1.13.x-623CE4?logo=terraform)
![Cloudflare](https://img.shields.io/badge/Cloudflare-5.10-orange?logo=cloudflare)
![CI Status](https://img.shields.io/github/actions/workflow/status/cchacon-dev/terraform-cloudflare-dns-automation/terraform-plan.yml?branch=main&label=CI%20Status&logo=githubactions)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

A **learning project** to explore Infrastructure as Code (IaC) with **Terraform** and **Cloudflare**.  
This is my **first Terraform project**, built as part of my homelab journey and DevOps learning path.  
The goal is to learn solid practices (automation, reproducibility, security) by starting small and improving continuously.

---

## 📖 Overview

This repository automates Cloudflare DNS management with Terraform and a GitHub Actions pipeline.  
It is written to be simple, reusable, and progressively more “enterprise-like” while remaining educational.

You can reuse it to:
- Learn Terraform + Cloudflare Provider basics
- Manage DNS records as code
- Run a plan-only CI (with linting, security checks, and tests)
- Use as a starter template for homelabs or small infra projects

---

## 🧱 Current Status

| Feature | Status |
|--------|-------|
| Terraform root env (`envs/prod`) | ✅ Working |
| Reusable module (`modules/dns_records`) | ✅ Added |
| Terraform native tests (`terraform test`) | ✅ Passing |
| TFLint + tfsec (CI) | ✅ Enabled |
| GitHub Actions workflow (plan-only) | ✅ Running |
| Remote State + Apply with approvals | 🔜 Future |
| Cloudflare Tunnel automation | 🔜 Future |
| Multi-environment setup | 🔜 Future |

---

## 🗂 Project Structure

```
terraform-cloudflare-dns-automation/
├── envs/
│   └── prod/
│       ├── main.tf
│       ├── providers.tf
│       ├── versions.tf
│       └── terraform.tfvars         # local only (ignored)
├── modules/
│   └── dns_records/
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       ├── versions.tf
│       └── dns_records.tftest.hcl   # terraform native tests
├── .github/
│   └── workflows/
│       └── terraform-plan.yml
├── .gitignore
└── README.md
```

---

## ⚙️ Prerequisites

| Requirement | Version | Notes |
|-------------|---------|-------|
| **Terraform** | ≥ 1.13.x | CLI installed locally or via CI |
| **Cloudflare Provider** | ≥ 5.10.x | Installed on `terraform init` |
| **Cloudflare Account** | Active domain | Needed to manage DNS |
| **Cloudflare API Token** | Scoped to your zone | Permissions: `Zone:Read`, `DNS:Edit` |
| **GitHub Account** | For CI pipeline | Optional for local-only usage |

---

## 🧩 Local Setup

1) Export environment variables:
```bash
export CLOUDFLARE_API_TOKEN="your_token"
export TF_VAR_zone_id="your_zone_id"
```

2) Define your records in `envs/prod/terraform.tfvars`:
```hcl
records = [
  { name = "demo-proof", type = "TXT",  content = "managed-by-terraform", ttl = 300, proxied = false },
  { name = "docs",       type = "CNAME", content = "example.com",         ttl = 300, proxied = false }
]
```

3) Run Terraform locally:
```bash
cd envs/prod
terraform init
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -auto-approve -var-file=terraform.tfvars
```

---

## 🧪 Tests (Terraform native)

- Tests live in `modules/dns_records/dns_records.tftest.hcl`.
- Run them offline (no real API calls):
```bash
cd modules/dns_records
terraform init -input=false
terraform test
```

---

## 🔍 Linting & Security (CI)

- **TFLint** checks style and common mistakes.
- **tfsec** runs via Docker: `docker run --rm -v "$PWD":/src aquasec/tfsec:latest /src`.

Both run automatically in the GitHub Actions workflow before the plan.

---

## 🤖 GitHub Actions (plan-only)

The workflow at `.github/workflows/terraform-plan.yml`:
- Runs `tflint`, `tfsec`, `terraform test` (module), and then `terraform fmt/validate/plan` for `envs/prod`.
- Generates `auto.tfvars.json` from repository secrets.

### Repository Secrets

| Secret | Description |
|--------|-------------|
| `CLOUDFLARE_API_TOKEN` | Cloudflare token with `Zone:Read` + `DNS:Edit` |
| `CF_ZONE_ID` | Zone ID of your domain |
| `CF_RECORDS_JSON` | JSON array with your DNS records |

---

## 🚀 Roadmap

- Add remote state backend (Terraform Cloud / S3 / Azure)
- Add an apply workflow with environment approvals
- Automate Cloudflare Tunnel with Terraform + Ansible/Kubernetes
- Add `dev`/`stage` environments

---

## 📚 References

- [Terraform Cloudflare Provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest)
- [Terraform Language](https://developer.hashicorp.com/terraform/language)
- [Cloudflare Developer Docs](https://developers.cloudflare.com/)
- [TFLint](https://github.com/terraform-linters/tflint)
- [tfsec](https://aquasecurity.github.io/tfsec/)
- [GitHub Actions Terraform setup](https://github.com/hashicorp/setup-terraform)

---

## 👤 Author

**Carlos Chacón** — homelab & DevOps learner, building reusable and secure IaC step by step.

If this helped you, feel free to **fork**, **star**, or open issues to suggest improvements.
