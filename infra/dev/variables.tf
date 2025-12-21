#--------------------------------------
# Resource Group Variables
#--------------------------------------

variable "resource_groups" {
  type = map(object({
    resource_group_name = string
    location            = string
    managed_by          = optional(string)
    environment         = optional(string)
    project             = optional(string)
  }))
}

#--------------------------------------
# Storage Account Variables
#--------------------------------------

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


#--------------------------------------
# Virtual Network Variables
#--------------------------------------

variable "vnets" {
  description = "Map of Virtual Networks to create in Azure"
  type = map(object({
    name                = string       # required — VNet का नाम
    address_space       = list(string) # required — VNet के IP Address Space (एक से ज्यादा CIDR)
    location            = string       # required — Azure Region where VNet will be deployed
    resource_group_name = string       # required — Existing Resource Group का नाम

    dns_servers             = optional(list(string)) # optional — Custom DNS servers in VNet
    tags                    = optional(map(string))  # optional — Tags to apply on VNet
    enable_ddos_protection  = optional(bool)         # optional — Enable DDoS protection setting
    ddos_protection_plan_id = optional(string)       # optional — If DDOS enabled then plan id
    subnet = optional(map(object({                   # optional — Sub‐nets map if you want inline creation
      name                              = string
      address_prefixes                  = list(string)
      private_endpoint_network_policies = optional(bool)
      service_endpoint_network_policies = optional(bool)
    })))
  }))
  default = {}
}

#--------------------------------------
# Public IP Variables
#--------------------------------------

variable "public_ips" {
  description = "Map of Public IP configurations"
  type = map(object({
    # ===== Required Arguments =====
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string # Static or Dynamic

    # ===== Optional Arguments =====
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string, "IPv4")
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    tags                    = optional(map(string))
    environment             = optional(string)
  }))
}



#--------------------------------------
# Linux Virtual Machine Variables
#--------------------------------------

variable "vms" {
  description = "Map of Azure Linux Virtual Machines to create"
  type = map(object({
    #----------------------------
    # Required Parameters
    #----------------------------
    name                  = string
    location              = string
    resource_group_name   = string
    size                  = string
    network_interface_ids = optional(list(string))
    subnet_name           = string
    virtual_network_name  = string
    pip_name              = string
    nic_name              = string
    nsg_name              = string
    script_name           = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))

    os_disk = object({
      caching              = string           # (Required) None | ReadOnly | ReadWrite
      storage_account_type = optional(string) # (Optional) Standard_LRS, Premium_LRS, etc.
      disk_size_gb         = optional(number)
      name                 = optional(string)
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
    })

    #----------------------------
    # Optional Parameters
    #----------------------------
    admin_username                  = optional(string)
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool, true)

    admin_ssh_key = optional(list(object({
      username   = string
      public_key = string
    })))

    source_image_id = optional(string)
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))

    availability_set_id = optional(string)
    zone                = optional(string)
    priority            = optional(string)
    eviction_policy     = optional(string)
    computer_name       = optional(string)
    tags                = optional(map(string))

    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    additional_capabilities = optional(object({
      ultra_ssd_enabled   = optional(bool)
      hibernation_enabled = optional(bool)
    }))

    termination_notification = optional(object({
      enabled = bool
      timeout = optional(string)
    }))

    encryption_at_host_enabled = optional(bool)
    secure_boot_enabled        = optional(bool)
    vtpm_enabled               = optional(bool)
  }))
}


#--------------------------------------
# Key Vault Variables
#--------------------------------------

variable "key_vaults" {
  description = "Map of Key Vaults with configuration details."
  type = map(object({
    # -------------------------
    # Required arguments
    # -------------------------
    name                = string
    location            = string
    resource_group_name = string
    sku_name            = string

    # -------------------------
    # Optional arguments
    # -------------------------
    tenant_id = optional(string)
    access_policy = optional(list(object({
      tenant_id               = string
      object_id               = string
      application_id          = optional(string)
      certificate_permissions = optional(list(string))
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      storage_permissions     = optional(list(string))
    })))

    enabled_for_deployment          = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    rbac_authorization_enabled      = optional(bool)

    network_acls = optional(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))

    purge_protection_enabled      = optional(bool)
    public_network_access_enabled = optional(bool)
    soft_delete_retention_days    = optional(number)
    tags                          = optional(map(string))
  }))
}


#--------------------------------------
# SQL Server Variables
#--------------------------------------

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
    mysql_server_name   = string

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

#--------------------------------------
# SQL Database Variables
#--------------------------------------

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


#---------------------------------------------------
# Bastion Host Variables
#---------------------------------------------------
variable "bastion_host" {
  description = "Map of Bastion Hosts to be created"
  type = map(object({
    # ---------- REQUIRED ----------
    name                 = string
    resource_group_name  = string
    location             = string
    subnet_name          = string
    virtual_network_name = string

    # ---------- OPTIONAL ----------
    copy_paste_enabled        = optional(bool, true)
    file_copy_enabled         = optional(bool, false)
    sku                       = optional(string, "Basic")
    ip_connect_enabled        = optional(bool, false)
    kerberos_enabled          = optional(bool, false)
    scale_units               = optional(number, 2)
    shareable_link_enabled    = optional(bool, false)
    tunneling_enabled         = optional(bool, false)
    session_recording_enabled = optional(bool, false)
    virtual_network_id        = optional(string)
    zones                     = optional(list(string))
    tags                      = optional(map(string), {})

    # ---------- BLOCK ----------
    ip_configuration = object({
      name           = string
      public_ip_name = string
    })
  }))
}
