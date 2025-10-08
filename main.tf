module "org" {
  source      = "./github/org"
  org_name    = local.org_name
  org_members = ["ismymiddlename"]
}

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

module "laundry" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "laundry-service"
    visibility  = "public"
    description = "laundry service description"
    codereaders = []
    maintainers = ["enghasib"]
    topics      = []
  }
}

module "judge_not_zero" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "judge-not-zero"
    visibility  = "public"
    description = "judge-not-zero description"
    codereaders = []
    maintainers = ["cy-r0x"]
    topics      = []
  }
}

module "bgce_bot" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "bgce-bot"
    visibility  = "public"
    description = "bgce-bot description"
    codereaders = []
    maintainers = ["twfksh"]
    topics      = []
  }
}

module "gw_two_style" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "gw2style"
    visibility  = "public"
    description = "gw2style description"
    codereaders = []
    maintainers = ["hazratali-uydevelopers"]
    topics      = []
  }
}

module "lazy_cli" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "lazy-cli"
    visibility  = "public"
    description = "lazy-cli description"
    codereaders = []
    maintainers = ["iammhador"]
    topics      = []
  }
}

module "code_echo" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "code-echo"
    visibility  = "public"
    description = "code-echo description"
    codereaders = []
    maintainers = ["Sadik-Sami"]
    topics      = []
  }
}

module "bgce_stream" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "bgce-stream"
    visibility  = "public"
    description = "bgce-stream description"
    codereaders = []
    maintainers = ["rahim-jr"]
    topics      = []
  }
}

module "archive_infra" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "archive-infra"
    visibility  = "public"
    description = "Manage archive infra from this repo"
    codereaders = []
    maintainers = ["saadrupai"]
    topics      = []
  }
}

module "vps_study" {
  source = "./github/repo"

  context = {
    owner       = local.org_name
    name        = "vps-study"
    visibility  = "private"
    description = "Manage vps to do primary studies and rnd"
    codereaders = []
    maintainers = ["saadrupai"]
    topics      = []
  }
}