output "record_ids" {
  description = "Managed record IDs"
  value       = { for k, r in cloudflare_dns_record.this : k => r.id }
}
