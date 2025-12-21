variable "mysql_server" {
  description = "Map of Azure SQL Servers with configuration details."
  type = map(object({
    # -------------------------
    # Required arguments
    # -------------------------
    name                = string
    resource_group_name = string
    location            = string
    version             = string

    # -------------------------
    # Optional arguments
    # -------------------------
    administrator_login                          = optional(string)
    administrator_login_password                 = optional(string)
    administrator_login_password_wo              = optional(string)
    administrator_login_password_wo_version      = optional(number)
    connection_policy                            = optional(string, "Default")
    express_vulnerability_assessment_enabled     = optional(bool, false)
    transparent_data_encryption_key_vault_key_id = optional(string)
    minimum_tls_version                          = optional(string, "1.2")
    public_network_access_enabled                = optional(bool, true)
    outbound_network_restriction_enabled         = optional(bool, false)
    primary_user_assigned_identity_id            = optional(string)

    # -------------------------
    # Nested: identity block
    # -------------------------
    identity = optional(object({
      type         = string                 # Allowed: SystemAssigned, UserAssigned, or both
      identity_ids = optional(list(string)) # Required when type = "UserAssigned"
    }))

    # -------------------------
    # Nested: azuread_administrator block
    # -------------------------
    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool, false)
    }))

    # -------------------------
    # Optional: Tags
    # -------------------------
    tags = optional(map(string))
  }))
}
