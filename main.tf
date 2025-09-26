module "test_repo" {
  source = "./github/repo"

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
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "infra"
    visibility  = "public"
    description = "Infra managed by Terraform"
    codereaders = []
    maintainers = []
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation", "managed"]
  }
}
