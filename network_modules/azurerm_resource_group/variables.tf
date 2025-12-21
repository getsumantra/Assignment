variable "resource_groups" {
  type = map(object({
    resource_group_name = string
    location            = string
    managed_by          = optional(string)
    environment         = optional(string)
    project             = optional(string)
  }))
}