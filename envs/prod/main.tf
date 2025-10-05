terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = "XvBg2ndf1OU5FsjEHIgFrcjja0dYHt0Rpg40L__F"
}

variable "zone_id" {
  default = "XvBg2ndf1OU5FsjEHIgFrcjja0dYHt0Rpg40L__F"
}

variable "domain" {
  default = "cchacon-dev.com"
}
# Create a DNS record
resource "cloudflare_dns_record" "www" {
  zone_id = var.zone_id
  name    = "www"
  type    = a
  proxied = true
  ttl     = true
}
