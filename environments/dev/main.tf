module "test_repo" {
  source = "../../platforms/github/modules/repo"

  context = {
    owner       = local.org_name
    name        = "test-repo"
    visibility  = "public"
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
    name        = "infrastructure"
    visibility  = "public"
    description = "Infra managed by Terraform"
    codereaders = []
    maintainers = []
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation", "managed"]
  }
}
