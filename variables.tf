variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "discord_token" {
  description = "Discord bot token"
  type        = string
  sensitive   = true
}
