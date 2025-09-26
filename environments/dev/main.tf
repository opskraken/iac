module "test_repo" {
  source = "../../platforms/github/modules/repo"

  context = {
    owner       = local.org_name
    name        = "test-repo"
    visibility  = "private"
    description = "A test repository managed by Terraform"
    codereaders = []
    maintainers = []
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation"]
  }
}

module "infra" {
  source = "../../platforms/github/modules/repo"

  context = {
    owner       = local.org_name
    name        = "infra"
    visibility  = "private"
    description = "Infra managed by Terraform"
    codereaders = []
    maintainers = []
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation", "managed"]
  }
}
