// (Replace local with S3, TFC, etc. if you have remote state.)
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
