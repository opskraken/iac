variable "org_members" {
  type    = set(string)
  default = []
}

variable "org_name" {
  type        = string
  description = "GitHub organization name"
}
