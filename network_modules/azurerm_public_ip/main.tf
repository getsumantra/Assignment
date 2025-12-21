resource "azurerm_public_ip" "pip" {
  for_each            = var.public_ips
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku != null ? each.value.sku : "Standard"

  tags = {
    environment = each.value.environment
  }
}


