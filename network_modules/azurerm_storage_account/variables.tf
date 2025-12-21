#-----------------------------------------------
# Storage Account Variable
#-----------------------------------------------
variable "storage_accounts" {
  description = "Map of Storage Accounts to be created"
  type = map(object({
    # ---------- REQUIRED ----------
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    # ---------- OPTIONAL ----------
    account_kind                      = optional(string, "StorageV2")
    provisioned_billing_model_version = optional(string)
    cross_tenant_replication_enabled  = optional(bool, false)
    access_tier                       = optional(string, "Hot")
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool, true)
    min_tls_version                   = optional(string, "TLS1_2")
    allow_nested_items_to_be_public   = optional(bool, true)
    shared_access_key_enabled         = optional(bool, true)
    public_network_access_enabled     = optional(bool, true)
    default_to_oauth_authentication   = optional(bool, false)
    is_hns_enabled                    = optional(bool, false)
    nfsv3_enabled                     = optional(bool, false)
    large_file_share_enabled          = optional(bool, false)
    local_user_enabled                = optional(bool, true)
    infrastructure_encryption_enabled = optional(bool, false)
    sftp_enabled                      = optional(bool, false)
    dns_endpoint_type                 = optional(string, "Standard")
    queue_encryption_key_type         = optional(string, "Service")
    table_encryption_key_type         = optional(string, "Service")

    # ---------- BLOCKS ----------
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))

    customer_managed_key = optional(object({
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
      user_assigned_identity_id = string
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string))
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))

    routing = optional(object({
      publish_internet_endpoints  = optional(bool, false)
      publish_microsoft_endpoints = optional(bool, false)
      choice                      = optional(string, "MicrosoftRouting")
    }))

    tags = optional(map(string), {})
  }))
}
