resource "azurerm_mssql_database" "mysql_db" {
  for_each = var.mysql_db

  name         = each.value.name
  server_id    = data.azurerm_mssql_server.mysql_server[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

  tags = {
    environment = each.value.tags["environment"]
  }

  lifecycle {
    prevent_destroy = true
  }
}
