terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.3"
}

provider "github" {
  owner = local.org_name
}

locals {
  org_name = "opskraken"
}