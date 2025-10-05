# 🌩️ terraform-cloudflare-dns-automation

![Terraform](https://img.shields.io/badge/Terraform-1.13.x-623CE4?logo=terraform)
![Cloudflare](https://img.shields.io/badge/Cloudflare-5.10-orange?logo=cloudflare)
![CI Status](https://img.shields.io/github/actions/workflow/status/cchacon-dev/terraform-cloudflare-dns-automation/terraform-plan.yml?branch=main&label=CI%20Status&logo=githubactions)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

A **learning project** to explore Infrastructure as Code (IaC) with **Terraform** and **Cloudflare**.  
This is my **first Terraform project**, created as part of my homelab journey and DevOps learning path.  
The goal is to understand how automation, reproducibility, and security are achieved in real DevOps environments — starting small and improving over time.

---

## 📖 Overview

This repository automates Cloudflare DNS management using Terraform.  
It’s built step by step, following enterprise practices while keeping it simple and educational.

You can reuse it to:
- Learn Terraform and Cloudflare Provider basics  
- Create and manage DNS records as code  
- Integrate Terraform with GitHub Actions (CI/CD)  
- Use as a starter template for homelabs or small infrastructure projects  

---

## 🧱 Current Status

| Feature | Status |
|----------|--------|
| Local Terraform configuration (`envs/prod`) | ✅ Working |
| Cloudflare Provider v5 | ✅ Configured |
| GitHub Actions workflow (plan-only) | ✅ Running successfully |
| Repository Secrets integration | ✅ Configured |
| Terraform Tests and Linters | 🔜 Coming soon |
| Remote State + Apply workflow | 🔜 Future improvement |

---

## 🧩 Project Structure

```
terraform-cloudflare-dns-automation/
├── envs/
│   └── prod/
│       ├── main.tf
│       ├── providers.tf
│       ├── versions.tf
│       └── terraform.tfvars        # local only (ignored)
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
| **Terraform** | ≥ 1.13.x | Installed locally or used in CI |
| **Cloudflare Provider** | ≥ 5.10.x | Installed automatically on `init` |
| **Cloudflare Account** | With an active domain | Needed to manage DNS |
| **Cloudflare API Token** | Scoped to your zone | Permissions: `Zone:Read`, `DNS:Edit` |
| **GitHub Account** | For running CI/CD | Optional for local use |

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

## 🤖 GitHub Actions (CI/CD)

This repository includes a **plan-only workflow** that runs on every push or pull request.  
It validates and formats Terraform code, then shows the **plan output** in Actions logs.

### Required Secrets

| Secret Name | Description |
|--------------|-------------|
| `CLOUDFLARE_API_TOKEN` | Cloudflare API token with `Zone:Read` and `DNS:Edit` |
| `CF_ZONE_ID` | Zone ID for your domain |
| `CF_RECORDS_JSON` | JSON array of DNS records (for plan preview) |

---

## 🚀 Next Steps

| Stage | Goal |
|--------|------|
| 🧩 Step 3 | Add Terraform tests and linting (TFLint, tfsec) |
| ☁️ Step 4 | Implement remote state backend |
| 🔐 Step 5 | Add “apply” workflow with approval gates |
| 🌐 Step 6 | Cloudflare Tunnel automation (Terraform + Ansible) |
| 🧱 Step 7 | Multi-environment setup (dev/stage/prod) |

---

## 💡 Lessons Learned

- How Terraform uses variables and providers  
- Why version pinning and `.gitignore` rules are critical  
- How to use GitHub Actions securely with secrets  
- Difference between **plan-only** CI and **apply** pipelines  
- First steps toward an enterprise-style IaC workflow  

---

## 🧠 Why I Built This

> “I wanted to understand how real DevOps workflows work — not just in theory, but hands-on.”  
>  
> This project is part of my **homelab learning journey**, combining Terraform, Cloudflare, and GitHub Actions to practice IaC automation.

---

## 📚 References

- [Terraform Cloudflare Provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest)
- [Terraform Docs](https://developer.hashicorp.com/terraform)
- [Cloudflare Developer Hub](https://developers.cloudflare.com/)
- [GitHub Actions for Terraform](https://github.com/hashicorp/setup-terraform)

---

## 🧑‍💻 Author

**Carlos Chacón**  
> Homelab & DevOps enthusiast — learning-by-doing approach — automation-first mindset  

If you’re also learning Terraform or building your own homelab, feel free to **fork** this repo, **open issues**, or share feedback!

---

**License:** MIT — free to learn, reuse, and adapt.
