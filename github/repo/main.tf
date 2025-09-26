terraform {
  required_version = ">= 1.12.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_repository" "default" {
  name                   = var.context.name
  description            = var.context.description
  visibility             = var.context.visibility
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  has_discussions        = false
  has_downloads          = false
  allow_auto_merge       = true
  allow_squash_merge     = true
  allow_merge_commit     = false
  allow_rebase_merge     = false
  archive_on_destroy     = true
  auto_init              = true
  delete_branch_on_merge = true
}

resource "github_repository_topics" "default" {
  repository = github_repository.default.name
  topics     = sort(var.context.topics)
}

resource "github_branch_protection" "default" {
  repository_id    = github_repository.default.id
  pattern          = "main"
  enforce_admins   = false
  allows_deletions = false
}

resource "github_team" "default" {
  name        = var.context.name
  description = "${var.context.owner}/${var.context.name}"
  privacy     = "closed"
}

resource "github_team" "readonly" {
  name           = "${var.context.name}-readonly"
  description    = "Read-only team for ${var.context.owner}/${var.context.name}"
  privacy        = "closed"
  parent_team_id = github_team.default.id
}

resource "github_team" "maintainers" {
  name           = "${var.context.name}-maintainers"
  description    = "Maintainers team for ${var.context.owner}/${var.context.name}"
  privacy        = "closed"
  parent_team_id = github_team.default.id
}

resource "github_team_repository" "readonly" {
  team_id    = github_team.readonly.id
  repository = github_repository.default.name
  permission = "pull"
}

resource "github_team_membership" "readonly" {
  for_each = toset(var.context.codereaders)
  team_id  = github_team.readonly.id
  username = each.key
  lifecycle {
    ignore_changes = [
      role
    ]
  }
}

resource "github_team_repository" "maintainers" {
  team_id    = github_team.maintainers.id
  repository = github_repository.default.name
  permission = "maintain"
}

resource "github_team_membership" "maintainers" {
  for_each = toset(var.context.maintainers)
  team_id  = github_team.maintainers.id
  username = each.key
  lifecycle {
    ignore_changes = [
      role
    ]
  }
}