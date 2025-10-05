# -------------------------------------------------------------------
# Terraform Native Test Suite for the dns_records module
# Purpose:
#   Validate that the module can successfully run "terraform plan"
#   with sample inputs, without reaching external APIs.
# -------------------------------------------------------------------

# Smoke test: ensures the module can plan correctly with two DNS records
run "plan_two_records" {
  command = plan

  variables {
    zone_id = "test-zone-id" # Mock zone for dry-run testing
    records = [
      {
        name    = "demo-proof"
        type    = "TXT"
        content = "managed-by-terraform"
        ttl     = 300
        proxied = false
      },
      {
        name    = "docs"
        type    = "CNAME"
        content = "example.com"
        ttl     = 300
        proxied = false
      }
    ]
  }
}

# Smoke test: verifies module planning with a single DNS record
run "plan_single_record" {
  command = plan

  variables {
    zone_id = "test-zone-id"
    records = [
      {
        name    = "only-one"
        type    = "TXT"
        content = "hello"
        ttl     = 300
        proxied = false
      }
    ]
  }
}
