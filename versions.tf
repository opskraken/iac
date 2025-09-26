terraform {
  required_version = ">= 1.5.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.45"   # Latest stable GitHub provider
    }

    # Using the maintained Discord provider by Lucky3028
    discord = {
      source  = "lucky3028/discord"
      version = "~> 2.2"    # Latest stable Discord provider
    }
  }
}