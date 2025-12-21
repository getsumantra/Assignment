variable "vnets" {
  description = "Map of Virtual Networks to create in Azure"

  type = map(object({
    name                = string       # required — VNet name
    address_space       = list(string) # required — IP address space(s)
    location            = string       # required — Azure region
    resource_group_name = string       # required — Existing Resource Group name

    bgp_community           = optional(string)       # optional — BGP Community
    dns_servers             = optional(list(string)) # optional — Custom DNS servers
    tags                    = optional(map(string))  # optional — Tags
    enable_ddos_protection  = optional(bool)         # optional — Enable DDoS
    ddos_protection_plan_id = optional(string)       # optional — DDoS Plan ID

    encryption = optional(object({                   # optional — Encryption settings
      enabled          = bool
      key_vault_key_id = string
    }))

    edge_zone               = optional(string)       # optional — Edge zone
    flow_timeout_in_minutes = optional(number)       # optional — Flow timeout
    ip_address_pool = optional(list(object({         # optional — IP pools
      name          = string
      address_space = list(string)
    })))

    subnet = optional(map(object({                   # optional — Subnets
      name                              = string
      address_prefixes                  = list(string)
      private_endpoint_network_policies = optional(bool)
      service_endpoint_network_policies = optional(bool)
      security_group_id                 = optional(string)
      default_outbound_access_enabled   = optional(bool)
      delegations = optional(list(object({
        name    = string
        service = string
      })))
    })))
  }))

  default = {}
}
