data "azurerm_mssql_server" "mysql_server" {
  for_each            = var.mysql_db
  name                = each.value.mysql_server_name
  resource_group_name = each.value.resource_group_name
}
