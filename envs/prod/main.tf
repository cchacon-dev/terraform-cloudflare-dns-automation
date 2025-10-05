variable "zone_id" { type = string }
variable "records" {
  type = list(object({
    name    = string
    type    = string
    content = string
    ttl     = number
    proxied = bool
  }))
}

module "dns" {
  source  = "../../modules/dns_records"
  zone_id = var.zone_id
  records = var.records
}

output "record_ids" {
  value = module.dns.record_ids
}
