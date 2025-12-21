module "resource_group" {
  source          = "../../network_modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage_account" {
  depends_on       = [module.resource_group]
  source           = "../../network_modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "networks" {
  depends_on = [module.resource_group]
  source     = "../../network_modules/azurerm_networks"
  vnets      = var.vnets
}

module "public_ips" {
  depends_on = [module.resource_group]
  source     = "../../network_modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "network_interface_Linux_vm" {
  depends_on = [module.resource_group, module.networks, module.public_ips]
  source     = "../../network_modules/azurerm_compute"
  vms        = var.vms
}

module "key_vaults" {
  depends_on = [module.resource_group]
  source     = "../../network_modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "mysql_server" {
  depends_on   = [module.resource_group]
  source       = "../../network_modules/azurerm_mssql_server"
  mysql_server = var.mysql_server
}

module "mysql_db" {
  depends_on = [module.mysql_server]
  source     = "../../network_modules/azurerm_mssql_db"
  mysql_db   = var.mysql_db
}

# module "bastion_host" {
#   depends_on = [ module.networks ]
#   source = "../../network_modules/azurerm_bastion_host"
#   bastion_host = var.bastion_host
# }