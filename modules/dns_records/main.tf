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
