variable "context" {
  description = "The context of the GitHub repository."
  type = object({
    owner                         = string
    name                          = string
    description                   = string
    visibility                    = string
    codereaders                   = list(string)
    maintainers                   = list(string)
    topics                        = list(string)
  })
}