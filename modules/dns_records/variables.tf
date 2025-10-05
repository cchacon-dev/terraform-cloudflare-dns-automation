variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "records" {
  description = "DNS records"
  type = list(object({
    name    = string
    type    = string # A, AAAA, CNAME, TXT, MX, etc.
    content = string
    ttl     = number
    proxied = bool
  }))
}
