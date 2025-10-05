variable "records" {
  description = "DNS records for prod (v5 schema)"
  type = list(object({
    name    = string
    type    = string # A, AAAA, CNAME, TXT, MX, etc.
    content = string # <-- antes era 'value'
    ttl     = number
    proxied = bool
  }))
}

variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

locals {
  records_map = { for r in var.records : "${r.name}_${r.type}_${r.content}" => r }
}

resource "cloudflare_dns_record" "this" {
  for_each = local.records_map

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  content = each.value.content
  proxied = each.value.proxied
}

output "record_ids" {
  value = { for k, r in cloudflare_dns_record.this : k => r.id }
}
