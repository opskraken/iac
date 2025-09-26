Rename a repository? after naming change in the resource... execute these commands in the changing directory:
```bash
terraform state mv module.infrastructure.github_repository.default module.infra.github_repository.default
terraform state mv module.infrastructure.github_team.default module.infra.github_team.default
terraform state mv module.infrastructure.github_team.readonly module.infra.github_team.readonly
terraform state mv module.infrastructure.github_team.maintainers module.infra.github_team.maintainers
terraform state mv module.infrastructure.github_team_repository.readonly module.infra.github_team_repository.readonly
terraform state mv module.infrastructure.github_team_repository.maintainers module.infra.github_team_repository.maintainers
terraform state mv module.infrastructure.github_repository_topics.default module.infra.github_repository_topics.default
terraform state mv module.infrastructure.github_branch_protection.default module.infra.github_branch_protection.default
```

Importing the deleted states for the repositories:
```bash
# --- Infrastructure repo & teams ---
terraform import module.infra.github_repository.default <repo-name>
terraform import module.infra.github_team.default <repo-name>
terraform import module.infra.github_team.maintainers <repo-name>-maintainers
terraform import module.infra.github_team.readonly <repo-name>-readonly
terraform import module.infra.github_branch_protection.default <repo-name>:main

```