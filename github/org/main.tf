terraform {
  required_version = ">= 1.12.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_membership" "org" {
  for_each = toset(var.org_members)
  username = each.value
  role     = "member"
}
