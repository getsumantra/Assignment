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
    virtual_network_name = string
    subnet_name          = string

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
