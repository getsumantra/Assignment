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
    nic_name              = string
    virtual_network_name  = string
    pip_name              = string
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

