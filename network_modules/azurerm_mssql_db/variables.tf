variable "mysql_db" {
  description = "Map of Azure SQL Databases configuration."
  type = map(object({
    # -------------------------
    # Required arguments
    # -------------------------
    name                = string
    mysql_server_name   = string
    resource_group_name = string
    # -------------------------
    # Optional arguments
    # -------------------------
    server_id                                                  = optional(string)
    auto_pause_delay_in_minutes                                = optional(number)
    create_mode                                                = optional(string, "Default")
    creation_source_database_id                                = optional(string)
    collation                                                  = optional(string)
    elastic_pool_id                                            = optional(string)
    enclave_type                                               = optional(string)
    geo_backup_enabled                                         = optional(bool, true)
    maintenance_configuration_name                             = optional(string, "SQL_Default")
    ledger_enabled                                             = optional(bool, false)
    license_type                                               = optional(string)
    max_size_gb                                                = optional(number)
    min_capacity                                               = optional(number)
    restore_point_in_time                                      = optional(string)
    recover_database_id                                        = optional(string)
    recovery_point_id                                          = optional(string)
    restore_dropped_database_id                                = optional(string)
    restore_long_term_retention_backup_id                      = optional(string)
    read_replica_count                                         = optional(number)
    read_scale                                                 = optional(bool)
    sample_name                                                = optional(string)
    sku_name                                                   = optional(string)
    storage_account_type                                       = optional(string, "Geo")
    transparent_data_encryption_enabled                        = optional(bool, true)
    transparent_data_encryption_key_vault_key_id               = optional(string)
    transparent_data_encryption_key_automatic_rotation_enabled = optional(bool, false)
    zone_redundant                                             = optional(bool)
    secondary_type                                             = optional(string, "Geo")

    # -------------------------
    # Nested: import block
    # -------------------------
    import = optional(object({
      storage_uri                  = string
      storage_key                  = string
      storage_key_type             = string
      administrator_login          = string
      administrator_login_password = string
      authentication_type          = string
      storage_account_id           = optional(string)
    }))

    # -------------------------
    # Nested: threat_detection_policy block
    # -------------------------
    threat_detection_policy = optional(object({
      state                      = optional(string, "Disabled")
      disabled_alerts            = optional(list(string))
      email_account_admins       = optional(string, "Disabled")
      email_addresses            = optional(list(string))
      retention_days             = optional(number)
      storage_account_access_key = optional(string)
      storage_endpoint           = optional(string)
    }))

    # -------------------------
    # Nested: long_term_retention_policy block
    # -------------------------
    long_term_retention_policy = optional(object({
      weekly_retention  = optional(string, "PT0S")
      monthly_retention = optional(string, "PT0S")
      yearly_retention  = optional(string, "PT0S")
      week_of_year      = optional(number)
    }))

    # -------------------------
    # Nested: short_term_retention_policy block
    # -------------------------
    short_term_retention_policy = optional(object({
      retention_days           = number
      backup_interval_in_hours = optional(number, 12)
    }))

    # -------------------------
    # Nested: identity block
    # -------------------------
    identity = optional(object({
      type         = string # Only "UserAssigned" supported
      identity_ids = list(string)
    }))

    # -------------------------
    # Optional: Tags
    # -------------------------
    tags = optional(map(string))
  }))
}
