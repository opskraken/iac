// (Replace local with S3, TFC, etc. if you have remote state.)
terraform {
  backend "remote" {
    organization = "NesoHQ"
    workspaces {
      name = "nesohq-infra"  # Must exist or be created
    }
  }
}