provider "github" {
  owner = local.org_name
}

locals {
  org_name = "NesoHQ"
  nesohq_default_homepage = "https://nesohq.org"
}

module "org" {
  source        = "./github/org"
  org_name      = local.org_name
  org_members   = []
}

# Introduction repository
module "intro" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "introduction-to-nesohq"
    visibility  = "public"
    description = "Introductory hub for NesoHQ, providing an overview of the organization's mission and projects, managed by Terraform for community onboarding"
    codereaders = []
    maintainers = ["saadrupai"]
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation", "nesohq", "introduction", "community", "onboarding"]
    has_issues  = true
    has_wiki    = true
    homepage    = local.nesohq_default_homepage
  }
}

# Infrastructure repository
module "infra" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "infra"
    visibility  = "public"
    description = "Centralized repository for managing NesoHQ's infrastructure configurations using Terraform, ensuring consistency and scalability"
    codereaders = []
    maintainers = ["saadrupai"]
    topics      = ["terraform", "infrastructure-as-code", "iac", "github", "automation", "managed", "infrastructure", "devops", "cloud"]
    branch_protection = {
      main = {
        require_signed_commits = true
        required_pull_request_reviews = {
          required_approving_review_count = 2
        }
      }
    }
  }
}

# Laundry service repository
module "laundry" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "laundry-service"
    visibility  = "public"
    description = "Online laundry service platform for ordering and tracking laundry with location-aware features, managed by Terraform"
    codereaders = ["itnishad", "gowaliullah"]
    maintainers = ["enghasib"]
    topics      = ["laundry-service", "e-commerce", "online-service", "location-based", "rest-api", "user-management", "order-tracking"]
    has_issues  = true
  }
}

# Judge Not Zero repository
module "judge_not_zero" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "judge-not-zero"
    visibility  = "public"
    description = "Open-source online judging platform for competitive programming with a scalable microservices architecture, Next.js frontend, and Go backend"
    codereaders = []
    maintainers = ["cy-r0x"]
    topics      = ["online-judge", "competitive-programming", "microservices", "nextjs", "golang", "rabbitmq", "postgresql", "sandbox"]
    has_issues  = true
    homepage    = local.nesohq_default_homepage
  }
}

# BGCE Bot repository
module "bgce_bot" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "bgce-bot"
    visibility  = "public"
    description = "Python-based chatbot for streamlining project discussions by linking pull requests and issues in development channels"
    codereaders = []
    maintainers = ["twfksh"]
    topics      = ["chatbot", "automation", "python", "github-api", "collaboration", "discord-bot", "development-tools"]
    has_issues  = true
  }
}

# GW2Style repository
module "gw_two_style" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "gw2style"
    visibility  = "public"
    description = "Community-driven fashion archive for Guild Wars 2 players to share and discover character outfits, hosted on Netlify with MongoDB"
    codereaders = []
    maintainers = ["hazratali-uydevelopers"]
    topics      = ["guild-wars-2", "fashion-archive", "community-platform", "netlify", "mongodb", "api-integration", "social-hub"]
    has_issues  = true
    homepage    = "https://gw2style.netlify.app"
  }
}

# Lazy CLI repository
module "lazy_cli" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "lazy-cli"
    visibility  = "public"
    description = "Bash-based CLI tool to automate development workflows, initializing projects and configuring environments across multiple languages"
    codereaders = []
    maintainers = ["iammhador"]
    topics      = ["cli-tool", "automation", "bash", "developer-tools", "project-initialization", "cross-platform", "workflow"]
    has_issues  = true
    homepage    = local.nesohq_default_homepage
  }
}

# Code Echo repository
module "code_echo" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "code-echo"
    visibility  = "public"
    description = "CLI tool to scan repositories and package them into AI-friendly files for documentation, refactoring, and security scanning"
    codereaders = []
    maintainers = ["Sadik-Sami"]
    topics      = ["cli-tool", "automation", "golang", "ai-integration", "documentation", "code-analysis", "refactoring"]
    has_issues  = true
    homepage    = local.nesohq_default_homepage
  }
}

# BGCE Stream repository
module "bgce_stream" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "bgce-stream"
    visibility  = "public"
    description = "One-click music streaming service for communities, enabling high-quality audio sharing with noise filtering and music mode"
    codereaders = ["twfksh"]
    maintainers = ["rahim-jr"]
    topics      = ["music-streaming", "audio", "community", "real-time", "collaboration", "streaming-service"]
    has_issues  = true
  }
}

# Archive Infrastructure repository
module "archive_infra" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "archive-infra"
    visibility  = "public"
    description = "Repository for archived NesoHQ infrastructure configurations, managed via Terraform for traceability and recovery"
    codereaders = []
    maintainers = ["saadrupai"]
    topics      = ["infrastructure", "archive", "terraform", "infrastructure-as-code", "devops", "backup"]
    has_issues  = true
    branch_protection = {
      main = {
        require_signed_commits = true
        required_pull_request_reviews = {
          required_approving_review_count = 1
        }
      }
    }
  }
}

# VPS Study repository
module "vps_study" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "vps-study"
    visibility  = "private"
    description = "Private repository for managing VPS configurations and conducting R&D studies for NesoHQ's infrastructure and projects"
    codereaders = []
    maintainers = ["saadrupai"]
    topics      = ["vps", "research", "development", "infrastructure", "prototyping", "private"]
    has_issues  = true
  }
}

# Lok Lagbe repository
module "lok_lagbe" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "lok-lagbe"
    visibility  = "public"
    description = "Web-based platform connecting skilled workers with employers for project-based or contract work, featuring user profiles, advanced search filters, secure communication, and a rating system"
    codereaders = []
    maintainers = ["itsrmizanur"]
    topics      = ["freelancing", "job-platform", "user-management", "search", "messaging", "contract-work", "employment", "social-impact", "web-app"]
    has_issues  = true
    homepage    = local.nesohq_default_homepage
  }
}

# Blood Donation repository
module "blood_donation" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "blood-donation"
    visibility  = "public"
    description = "Platform to connect blood donors with those in need, allowing user registration, donor updates, and location-based searches for specific blood groups"
    codereaders = []
    maintainers = ["shojib116"]
    topics      = ["blood-donation", "health", "user-management", "search", "social-impact", "donor-platform", "location-based", "community", "medical"]
    has_issues  = true
  }
}

# EduSphere repository
module "edusphere" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "edusphere"
    visibility  = "public"
    description = "Centralized platform for educational institutions to manage student enrollment, exam results, courses, news, and more, with role-based access and optional payment integration"
    codereaders = []
    maintainers = ["sabbirn53"]
    topics      = ["education", "management-platform", "user-management", "analytics", "payment", "enrollment", "exam-results", "institution-management", "dashboard"]
    has_issues  = true
    homepage    = local.nesohq_default_homepage
  }
}

# Volunteering Match repository
module "volunteering_match" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "volunteering-match"
    visibility  = "public"
    description = "Platform to match volunteers with NGOs based on skills, availability, and interests, using an algorithm to connect the right people to impactful projects"
    codereaders = []
    maintainers = ["kabirhiking"]
    topics      = ["volunteering", "ngo", "matching-algorithm", "social-impact", "community", "skills-based", "non-profit", "collaboration", "app"]
    has_issues  = true
  }
}

# E-Chat repository
module "e_chat" {
  source = "./github/repo"
  context = {
    owner       = local.org_name
    name        = "e-chat"
    visibility  = "public"
    description = "Free, unlimited AI voice tool for learning and practicing languages (starting with English), offering real-time corrections, offline mode, and progress tracking"
    codereaders = []
    maintainers = ["Anika1111122222"]
    topics      = ["ai", "voice-tool", "language-learning", "education", "real-time", "offline-mode", "progress-tracking", "free-access", "multilingual"]
    has_issues  = true
  }
}