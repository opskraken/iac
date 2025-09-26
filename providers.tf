
provider "github" {
  token = var.github_token
  owner = "opskraken"
}

provider "discord" {
  token = var.discord_token
}
