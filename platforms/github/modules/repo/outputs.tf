output "repository_clone_url" {
  description = "HTTPS clone URL of the repository"
  value       = github_repository.default.http_clone_url
}

output "repository_html_url" {
  description = "HTML URL of the repository"
  value       = github_repository.default.html_url
}

output "default_team_id" {
  description = "ID of the default team for the repository"
  value       = github_team.default.id
}

output "readonly_team_id" {
  description = "ID of the read-only team for the repository"
  value       = github_team.readonly.id
}

output "maintainers_team_id" {
  description = "ID of the maintainers team for the repository"
  value       = github_team.maintainers.id
}
