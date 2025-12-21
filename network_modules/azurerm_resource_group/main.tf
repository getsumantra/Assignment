resource "azurerm_resource_group" "rg" {
  for_each   = var.resource_groups                  # This is an expression 
  name       = each.value.resource_group_name
  location   = each.value.location
  managed_by = each.value.managed_by
  tags = { 
    environment = each.value.environment
    project     = each.value.project
  }
}
