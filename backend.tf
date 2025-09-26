// (Replace local with S3, TFC, etc. if you have remote state.)
terraform {
  backend "remote" {
    organization = "opskraken"

    workspaces {
      name = "opskraken-practice"
    }
  }
}
