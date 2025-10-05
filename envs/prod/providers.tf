variable "cloudflare_api_token" {
  description = "Prefer environment variable CLOUDFLARE_API_TOKEN"
  type        = string
  default     = ""
  sensitive   = true
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token != "" ? var.cloudflare_api_token : null
}
